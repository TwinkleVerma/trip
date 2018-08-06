$(document).ready(function(){
	$('#search_btn').click(function(){
		source = $('#source').val();
		destination = $('#destination').val();
		date = $('#date').val();
		hash = {
			url : '/itineraries/find', 
			type: 'GET', 
			data: {
				source: source,
				destinition: destination, 
				date: date
			}
		};
		$.ajax(hash);
	});
});