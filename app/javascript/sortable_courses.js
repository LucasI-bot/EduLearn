document.addEventListener("turbolinks:load", function() {
    // Initialize Sortable.js for sections
    Sortable.create(document.getElementById('sortable-sections'), {
        handle: '.section',
        animation: 150,
        onEnd: function(evt) {
            var sectionsIds = [];
            $('#sortable-sections .section').each(function(index, element) {
                sectionsIds.push($(element).data('section-id'));
            });

            // Send an AJAX request to update the order
            $.ajax({
                type: 'PATCH',
                url: $('#sortable-sections').data('course_url') + '/order_sections',
                data: { sections: sectionsIds }
            });
            console.log('Sections reordered');
        }
    });

    // Initialize Sortable.js for lectures
    var lectures = document.querySelectorAll('.sortable-lectures');
    lectures.forEach(function(lectureList) {
        Sortable.create(lectureList, {
            group: 'lectures',
            animation: 150,
            onEnd: function(evt) {
                var orderData = [];
                $('.sortable-lectures .lecture').each(function(index, element) {
                    var lectureId= $(element).data('lecture-id');
                    var sectionId= $(element).closest('.section').data('section-id');
                    orderData.push({ lecture_id: lectureId, section_id: sectionId })
                });

                // Send an AJAX request to update the order
                $.ajax({
                    type: 'PATCH',
                    url: $('#sortable-sections').data('course_url') + '/order_lectures',
                    data: { data: orderData }
                });
                console.log('Lectures reordered');
            }
        });
    });

    // Initialize Sortable.js for exams
    var exams = document.querySelectorAll('.sortable-exams');
    exams.forEach(function(examList) {
        Sortable.create(examList, {
            group: 'exams',
            animation: 150,
            onEnd: function(evt) {
                var orderData = [];
                $('.sortable-exams .exam').each(function(index, element) {
                    var examId= $(element).data('exam-id');
                    var sectionId= $(element).closest('.section').data('section-id');
                    orderData.push({ exam_id: examId, section_id: sectionId })
                });

                // Send an AJAX request to update the order
                $.ajax({
                    type: 'PATCH',
                    url: $('#sortable-sections').data('course_url') + '/order_exams',
                    data: { data: orderData }
                });
                console.log('Exams reordered');
            }
        });
    });
});