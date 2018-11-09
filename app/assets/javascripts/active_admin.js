#= require active_admin/base

$(document).ready(function(){
  $('#user_flight_ids_input').addClass('hide');

  $('#user_role_ids').click(function(){
    if($('#user_role_ids').val()==6){
      $('#user_flight_ids_input').removeClass('hide');
    }
    else{
      $('#user_flight_ids_input').addClass('hide');
    }
});
});
