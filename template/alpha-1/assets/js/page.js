var workspace = {
	csrf_token: null,
	alert: function(params){
		var title = typeof(params.title) != 'undefined' ? params.title : '';
		var text = typeof(params.text) != 'undefined' ? params.text : '';
		var type = typeof(params.type) != 'undefined' ? params.type : 'success';

		switch(type){
			case 'success':

			break;

			case 'warning':				
				swal({   
				    title: title,   
				    text: text,   
				    type: 'warning',   
				    showCancelButton: true,   
				    confirmButtonColor: "#DD6B55",   
				    confirmButtonText: "Yes, delete it!", 
				    closeOnConfirm: false 
				}, function(){  
				    swal("Deleted!", "Your imaginary file has been deleted.", "success"); 
				});
			break;
		}
	}
}

$(document).ready(function() {
    workspace.csrf_token = $('#csrf_token').val();
});