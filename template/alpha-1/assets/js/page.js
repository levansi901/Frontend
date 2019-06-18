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
			        return false;
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
		var time = typeof(params.time) != 'undefined' ? params.time : 0;
		var time_default = 0;
		var icon, wrap_class = '';		
		switch(type){
			case 'sucess':
				wrap_class = 'green';
				icon = '<i class="material-icons m-r-lg">check</i>';
				time_default = 2000;
			break;

			case 'error':
				wrap_class = 'red darken-2';
				icon = '<i class="material-icons m-r-lg">close</i>';
				time_default = 3000;
			break;
		}

		if(time == 0){
			time = time_default;
		}

	    Materialize.toast(icon + title, time, wrap_class, callback);
	},
	ajaxSubmitForm: function(params){
		var self = this;

	    var url = typeof(params.url) != 'undefined' ? params.url : '';
	    var url_redirect = typeof(params.url_redirect) != 'undefined' ? params.url_redirect : '';
	    var type = typeof(params.type) != 'undefined' ? params.type : 'POST';
	    var type_data = typeof(params.type_data) != 'undefined' ? params.type_data : 'json';
	    var data = typeof(params.data) != 'undefined' ? params.data : {};
	    var async = typeof(params.async) != 'undefined' ? params.async : true;

	    if(url.length == 0){
	    	self.notification({
            	type: 'error',
            	title: 'Đường dẫn thực thi không hợp lệ'
            });
            return false;
	    }
		$.ajax({
			headers: {
		        'X-CSRF-Token': self.csrf_token
		    },
	        async: async,
	        url: url,
	        type: type,
	        dataType: type_data,
	        data: data,	        
	        cache: false,
	        processData: false,
	    }).done(function(response) {
		   	var status = typeof(response.status) != 'undefined' ? response.status : true;
        	var message = typeof(response.message) != 'undefined' ? response.message : '';

            if (status) {
            	self.notification({title: message}, function(){
            		if(url_redirect.length > 0){
            			window.location.href = url_redirect;
            		}
            	});                
            } else {
                self.notification({
                	type: 'error',
                	title: message
                });
            }
		}).fail(function(jqXHR, textStatus, errorThrown) {
		    self.notification({
            	type: 'error',
            	title: textStatus + ': ' + errorThrown
            });
		});
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