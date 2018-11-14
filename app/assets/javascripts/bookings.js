$(document).on('turbolinks:load', function() {
  $(".cancel_booking_button").on('click', function(){
    if (confirm('Are you sure, you want to cancel booking?')) {
      $('.loader').removeClass("hide");
      id = $(this).attr("id");
      booking_id = $("#"+id).attr("booking_id");
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url : '/bookings/'+booking_id,
        type: 'PATCH',
        complete: hideLoadingImage
      });
    }
    else{
      return false;
    }
  });

  $("#booking_btn").on('click', function(){
    $('.loader').removeClass("hide");
    date = $('#date').val();
    cost = $('#cost').val();
    schedule = $('#schedule').val();
    user_id = $('#user_id').val();
    $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url : '/users/'+user_id+'/bookings',
        type: 'POST',
        dataType: 'script',
        data: {
          date: date,
          cost: cost,
          schedule: schedule
        },
        success: hideLoadingImage,
        complete: redirectToRoot
      });
  });

  function redirectToRoot() {
    Turbolinks.visit('/')
  }

  function hideLoadingImage() {
    $('.loader').addClass("hide");
  }
});
