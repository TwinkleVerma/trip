$(document).on('turbolinks:load', function() {
	$('.login-form').validate({
		rules: {
			'user[password]': {
				required: true,
				minlength: 6
			},
			'user[email]': {
					required: true,
					email: true
			}
		},
		messages: {
			'user[password]': {
				required: "Password required",
				minlength: "Length must be greater than 10"
			},
			'user[email]': {
				required: "Email address required",
				email: "Email address must be valid"
			}
		},
		submitHandler: function (form) {
			form.submit();
    },
    errorPlacement: function(error, element) {
			element.after(error).after('<br/>');
   	}
  });

	$('.registration-form').validate({
		rules: {
			'user[name]':{
				required: true,
				minlength: 3
			},
			'user[password]': {
				required: true,
				minlength: 6
			},
			'user[email]': {
				required: true,
				email: true
			}
		},
		messages: {
			'user[name]':{
				required: "Name required",
				minlength: "Length must be greater than 3"
			},
			'user[password]': {
				required: "Password required",
				minlength: "Length must be greater than 6"
			},
			'user[email]': {
				required: "Email address required",
				email: "Email address must be valid"
			}
		},
		submitHandler: function (form) {
			form.submit();
    },
    errorPlacement: function(error, element) {
      element.after(error).after('<br/>');
   	}
	});

	$('.edit-form').validate({
		rules: {
			'user[name]':{
				required: true,
				minlength: 3
			},
			'user[password]': {
				required: true,
				minlength: 6
			},
			'user[email]': {
				required: true,
				email: true
			},
			'user[contact]': {
				required: true,
				minlength: 10,
				maxlength: 10,
				digits: true
			},
			'user[user_image_attributes][picture]':{
				required: true,
			}
		},
		messages: {
			'user[name]':{
				required: "Name required",
				minlength: "Length must be greater than 3"
			},
			'user[password]': {
				required: "Password required",
				minlength: "Length must be greater than 6"
			},
			'user[email]': {
					required: "Email address required",
					email: "Email address must be valid"
			},
			'user[contact]': {
				required: "Contact number required",
				minlength: "Contact number must be of 10 digit",
				maxlength: "Contact number must be of 10 digit",
				digits: "Contact should contain digits"
			},
			'user[user_image_attributes][picture]':{
				required: "User image required",
			}
		},
		submitHandler: function (form) {
			form.submit();
    }
	});

	jQuery.validator.addMethod("notEqualToGroup", function (value, element, options) {
    var elems = $(element).parents('form').find(options[0]);
    var valueToCompare = value;
    var matchesFound = 0;
    jQuery.each(elems, function () {
        thisVal = $(this).val();
        if (thisVal == valueToCompare) {
            matchesFound++;
        }
    });
    if (this.optional(element) || matchesFound <= 1) {
        return true;
    }
  }, jQuery.format("Please enter a Unique Value."))


	$('.itineraries-form').validate({
		rules: {
			'source':{
				required: true,
				notEqualToGroup: ['.distinctecity']
			},
			'destinition': {
				required: true,
				notEqualToGroup: ['.distinctecity']
			},
			'date': {
					required: true
			}
		},
		messages: {
			'source':{
				required: "Source city required",
				notEqualToGroup: "The source city and destination city can not be same"
			},
			'destinition': {
				required: "Destination city required",
				notEqualToGroup: "The source city and destination city can not be same"
			},
			'date': {
					required: "date of journey required"
			}
		},
    errorPlacement: function(error, element) {
    	if(element.attr("type") != "date"){
      	element.after(error).after('<br/>');
    	}

    	if(element.attr("type") == "date"){
    		element.after(error);	
   		}

   	}
	});
});