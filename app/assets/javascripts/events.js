$(document).on("ready page:load", function () {
  if ($('.event-form').length) {
    var form = $('.event-form');

    form.find('#add-item').on('click', function() {
      var fs = form.find('fieldset.schedule-item').last();
      var index = fs.data('index') + 1;
      var fs0 = fs.clone();
      var row0 = fs0.find('div.form-group').first();
      var row1 = fs0.find('div.form-group').last();

      fs0.addClass('added').data('index', index + 1);

      row0.find('input[type="hidden"]').remove();
      row0.find('input[type="checkbox"]').parent().remove();
      row0.find('label:nth-of-type(1)').text("日程(" + (index + 1) + ")");
      row0.find('label:nth-of-type(2)')
        .attr('for', 'event_form_schedule_items_' + index + '_start_date');
      row0.find('input[type="date"]')
        .attr('id', 'event_form_schedule_items_' + index + '_start_date')
        .attr('name', 'event_form[schedule_items][' + index + '][start_date]');
      row0.find('input[type="time"]')
        .attr('id', 'event_form_schedule_items_' + index + '_start_time')
        .attr('name', 'event_form[schedule_items][' + index + '][start_time]');

      row1.find('label:nth-of-type(1)')
        .attr('for', 'event_form_schedule_items_' + index + '_end_date');
      row1.find('input[type="date"]')
        .attr('id', 'event_form_schedule_items_' + index + '_end_date')
        .attr('name', 'event_form[schedule_items][' + index + '][end_date]');
      row1.find('input[type="time"]')
        .attr('id', 'event_form_schedule_items_' + index + '_end_time')
        .attr('name', 'event_form[schedule_items][' + index + '][end_time]');

      fs0.find('input').val('');
      fs0.insertAfter(fs);
      form.find('#remove-item').removeClass('disabled');
    });

    form.find('#remove-item').on('click', function() {
      var fs = form.find('fieldset.added').last();
      fs.remove();
      if (form.find('fieldset.added').length == 0) {
        form.find('#remove-item').addClass('disabled');
      }
    });

    form.find('.destroy-item').on('click', function() {
      if ($(this).is(':checked')) {
        $(this).closest('fieldset')
          .addClass('disabled')
          .find('input[type="date"], input[type="time"]')
          .attr('disabled', 'disabled');
        if (form.find('input[type="checkbox"]:not(:checked)').length == 1) {
          form.find('input[type="checkbox"]:not(:checked)').attr('disabled', 'disabled');
        }
      } else {
        $(this).closest('fieldset').find('input')
          .removeAttr('disabled').removeClass('disabled');
        form.find('input[type="checkbox"]').removeAttr('disabled');
      }
    });
  }
});
