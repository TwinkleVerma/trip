$(document).on('click', '.log_in', function(){
  if ($("#log_in").attr("class") == 'hide'){
    if ($("#sign_up").attr("class") == 'show'){
      $("#sign_up").attr('class', 'hide');
      $("#log_in").attr('class', 'show');
    }
    else{
      $("#log_in").attr('class', 'show');
    }
  }
	else
    $("#log_in").attr('class', 'hide');
});


$(document).on('click', '.sign_up', function(){
  if ($("#sign_up").attr("class") == 'hide'){
    if ($("#log_in").attr('class', 'show')){
      $("#log_in").attr('class', 'hide');
      $("#sign_up").attr('class', 'show');
    }
  }
  else
    $("#sign_up").attr('class', 'hide');
});