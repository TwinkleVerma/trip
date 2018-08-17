$(document).on('turbolinks:load', function() {
  $(".cancel_booking_button").on('click', function(){
    if (confirm('Are you sure, you want to cancel booking?')) {
      id = $(this).attr("id");
      booking_id = $("#"+id).attr("booking_id");
      $.ajax({
        url : '/bookings/'+booking_id, 
        type: 'PATCH'
      });
    }
    else{
      return false;
    }
  });
});