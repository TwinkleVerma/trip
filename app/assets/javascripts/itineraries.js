$(document).on('turbolinks:load', function() {
  var airline_time = [];
  var airline_name = [];
  var time_duration = '';
  var price_range = '';
  var data = {};
  var source = $('#source').val();
  var destinition = $('#destinition').val();
  var date = $('#date').val();

  $(".airlines_time_checkbox").on('click', function(){
    if($(this).prop("checked") == true){
      if ($(this).val() == "morning"){
        airline_time.push(["00:00:00","05:59:00"]);
      }
      if ($(this).val() == "noon") {
        airline_time.push(["06:00:00","11:59:00"]);
      }
      if ($(this).val() == "evening") {
        airline_time.push(["12:00:00","17:59:00"]);
      }
      if ($(this).val() == "night") {
        airline_time.push(["18:00:00","23:59:00"]);
      }
    }
    else if($(this).prop("checked") == false){
      if (airline_time.indexOf($(this).val()) > -1) {
        airline_time.splice(airline_time.indexOf($(this).val()), 1);
      }
    }
    ajax_call();
  });

  $(".airlines_name_checkbox").on('click', function(){
    if($(this).prop("checked") == true){
      airline_name.push($(this).val());
    }
    else if($(this).prop("checked") == false){
      if (airline_name.indexOf($(this).val()) > -1) {
        airline_name.splice(airline_name.indexOf($(this).val()), 1);
      }
    }
    ajax_call();
  });

  $("#time_duration").on('input', function(){
    $("#val").text($("#time_duration").val()+" hrs.");
    time_duration = $("#time_duration").val();
    ajax_call();
  });

  $("#price").on('input', function(){
    $("#priceval").text("₹ "+$("#price").val());
    price_range = $("#price").val();
    ajax_call();
  });

  function ajax_call(data){
    $.ajax({
      url : '/itineraries', 
      type: 'GET',
      dataType: 'script',
      data: {
        source: source,
        destinition: destinition,
        date: date,
        airline_time: airline_time,
        airline_name: airline_name,
        time_duration: time_duration, 
        price_range: price_range
      }
    });
  }
});