var ss_backend = {
	csrf_token: null,
	alertWarning: function(params, callback){
		if (typeof(callback) != 'function') {
	        callback = function () {};
	    }

		var type = typeof(params.type) != 'undefined' ? params.type : 'warning';
		var title = typeof(params.title) != 'undefined' ? params.title : '';
		var text = typeof(params.text) != 'undefined' ? params.text : '';		
		var reason_validation = typeof(params.reason_validation) != 'undefined' ? params.reason_validation : 'Vui lòng nhập lý do xóa';

		swal({   
		    title: title,   
		    text: text,   
		    type: type,   
		    confirmButtonText: 'Đồng ý', 
		    cancelButtonText: 'Hủy bỏ',
		    showCancelButton: true,   
		    closeOnConfirm: true,
		}, function(response){  

			if(type == 'input'){
				if (response === false) return false;              
			    if (response === '') {     
			        swal.showInputError(reason_validation);     
			        return false   
			    }   
			}

			if (response && type == 'warning') {
		        callback();
		    }

		});
	},
	notification: function(params, callback){
		if (typeof(callback) != 'function') {
	        callback = function () {};
	    }
	    var type = typeof(params.type) != 'undefined' ? params.type : 'sucess';
		var title = typeof(params.title) != 'undefined' ? params.title : '';
		var time = typeof(params.time) != 'undefined' ? params.time : 3000;
		var icon, wrap_class = '';

		switch(type){
			case 'sucess':
				wrap_class = 'green';
				icon = '<i class="material-icons m-r-lg">check</i>';
			break;

			case 'error':
				wrap_class = 'red';
				icon = '<i class="material-icons m-r-lg">close</i>';
			break;
		}
	    Materialize.toast(icon + title, time, wrap_class, callback);
	}
}

$(document).ready(function() {
    ss_backend.csrf_token = $('#csrf_token').val();
    $('.datepicker').pickadate({
        // selectMonths: true,
        // selectYears: 15
    });
});


$(document).ajaxStart(function () {
    preloader.on();
});

$(document).ajaxComplete(function () {
    preloader.off();
});

$(document).ajaxError(function () {
    preloader.off();
});