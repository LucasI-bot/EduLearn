class Inscription < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :payments, dependent: :destroy

  scope :by_name, -> (q) { joins(:user).where("lower(COALESCE(users.alias, CONCAT(users.last_name, ' ', users.first_name)))  LIKE ?", "%#{q}%") }
  scope :by_course_id, -> (q) { where(course_id: q) }

  def order_value
    @course = self.course
    @user = self.user
    @order = self.course.rating.to_f / 2

    if @course.sections.count > 3
      @order += 0.2
    end

    if Lecture.where(section_id: @course.sections.map{|a| a.id}).count > 9
      @order += 0.2
    end

    if Exam.where(section_id: @course.sections.map{|a| a.id}).count > 5
      @order += 0.2
    end

    @course.user.courses.each do |course|
      if @user.inscriptions.where(paid: true).map{|a| a.course}.include?(course)
        @order += 0.5
      end
    end

    @order += ((@course.user.courses.where.not(rating: nil).map{|a| a.rating}.sum.to_f / @course.user.courses.where.not(rating: nil).map{|a| a.rating}.size.to_f) / 3)

    @user.subjects.each do |subject|
      if @course.subjects.include?(subject)
        @order += 0.4
      end
    end

    @user.skills.each do |skill|
      if @course.skills.include?(skill)
        @order += 0.3
      end
    end

    @courses_subjects = Array.new(Subject.all.count, 0)
    @courses_skills = Array.new(Skill.all.count, 0)

    @user.inscriptions.where(paid: true).map{|a| a.course}.each do |course|
      course.subjects.each do |subject|
        @courses_subjects[subject.id - 1] += 1
      end
      course.skills.each do |skill|
        @courses_skills[skill.id - 1] += 1
      end
    end

    @course.subjects.each do |subject|
      @order += @courses_subjects[subject.id - 1].to_f * 0.4
    end

    @course.skills.each do |skill|
      @order += @courses_skills[skill.id - 1].to_f * 0.3
    end

    self.update(order: @order)
  end
end
