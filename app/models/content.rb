class Content < ApplicationRecord
  belongs_to :lecture

  has_one_attached :video
  has_one_attached :pdf

  validate :accepted_content

  enum content_type: %i[text_img video pdf]

  def accepted_content
    case content_type
    when 'text_img'
      unless text.present?
        errors.add(:text, "El bloque de texto e imágenes no puede estar vacío")
      end
    when 'video'
      unless video.attached?
        errors.add(:video, "Debe subir un archivo de video")
      end

      unless video.content_type.in?(%w[video/mp4 video/mpeg video/quicktime video/x-ms-wmv video/x-flv video/webm])
        errors.add(:video, "El archivo debe ser de un formato de video válido")
      end
    when 'pdf'
      unless pdf.attached?
        errors.add(:pdf, "Debe subir un archivo pdf")
      end

      unless pdf.content_type.in?(%w[application/pdf])
        errors.add(:pdf, "El archivo debe ser formato pdf")
      end
    end
  end
end
