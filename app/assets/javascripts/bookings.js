$(document).on('turbolinks:load', function() {
  $(".cancel_booking_button").on('click', function(){
    id = $(this).attr("id");
    booking_id = $("#"+id).attr("booking_id");
    $.ajax({
      url : '/bookings/'+booking_id, 
      type: 'PATCH'
    });
  });
});