String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

var ss_backend = {
	csrf_token: null,
	init: function(){

	},
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
	    var type = typeof(params.type) != 'undefined' ? params.type : 'success';
		var title = typeof(params.title) != 'undefined' ? params.title : '';
		var time = typeof(params.time) != 'undefined' ? params.time : 0;
		var time_default = 0;
		var icon, wrap_class = '';		
		switch(type){
			case 'success':
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
	showValidateError: function(params, callback){
		var input = typeof(params.input_object) != 'undefined' ? params.input_object : null;
		var error_message = typeof(params.error_message) != 'undefined' ? params.error_message : null;	

		if(input.length > 0 && error_message.length > 0){
			input.next('label.error').remove();
			if (typeof(callback) != 'function') {
		        callback = function () {};
		    }
			var id = typeof(input.attr('id')) != 'undefined' ? input.attr('id') + '-error' : '';
			var error = '<label id="' + id + '" class="error" for="' + id + '">' + error_message + '</label>';
			input.after(error).focus();
			callback();
		}		
	},
	ajaxSubmitForm: function(params){
		var self = this;
	    var url = typeof(params.url) != 'undefined' ? params.url : '';	    
	    var type = typeof(params.type) != 'undefined' ? params.type : 'POST';
	    var type_data = typeof(params.type_data) != 'undefined' ? params.type_data : 'json';
	    var data = typeof(params.data) != 'undefined' ? params.data : {};
	    var async = typeof(params.async) != 'undefined' ? params.async : true;
	    var url_redirect = typeof(params.url_redirect) != 'undefined' ? params.url_redirect : '';
	    var after_save = typeof(params.after_save) != 'undefined' ? params.after_save : 'edit';
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
	        contentType: false,
	    }).done(function(response) {
		   	var success = typeof(response.success) != 'undefined' ? response.success : false;
        	var message = typeof(response.message) != 'undefined' ? response.message : '';
        	var data = typeof(response.data) != 'undefined' ? response.data : {};

            if (success) {     
            	if(typeof(data.id) != 'undefined' && after_save == 'edit' && url_redirect.length > 0){
            		url_redirect = url_redirect + data.id
            	}

            	if(typeof(data.id) == 'undefined' && after_save == 'edit' && url_redirect.length > 0){
            		url_redirect = '';
            	}
            	self.notification({title: message}, function(){
            		if(url_redirect.length > 0){
            			window.location.href = url_redirect;
            		}else{
            			location.reload();
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
	},
	callAjax: function(params){
		var self = this;
		
		var ajax = $.ajax({
			headers: {
		        'X-CSRF-Token': self.csrf_token
		    },
	        async: typeof(params.async) != 'undefined' ? params.async : true,
	        url: typeof(params.url) != 'undefined' ? params.url : '',
	        type: typeof(params.type) != 'undefined' ? params.type : 'POST',
	        dataType: typeof(params.data_type) != 'undefined' ? params.data_type : 'JSON',
	        data: typeof(params.data) != 'undefined' ? params.data : {},    
	        cache: typeof(params.cache) != 'undefined' ? params.cache : false,
	    }).fail(function(jqXHR, textStatus, errorThrown){
	    	if(typeof(params.not_show_error) == 'undefined'){
	    		ss_backend.notification({
			    	type: 'error',
			    	title: errorThrown
			    });
	    	}			
		});
	    return ajax;
	},
	activeMenu: function(){
		var href = window.location.href.split(document.domain);
        var url = href[1];
        var url_reference = $('body').attr('url-reference');
        if ($('#left-sidebar a[href="' + url + '"]').length > 0) {
	        a_active = $('#left-sidebar a[href="' + url + '"]');
	    } else if (typeof(url_reference) != 'undefined' && $('#left-sidebar a[href="' + url_reference + '"]').length > 0) {
	        a_active = $('#left-sidebar a[href="' + url_reference + '"]');
	    }
	    
	    if(typeof(a_active) != 'undefined'){
	    	a_active.addClass('active-page');	
	    	// active menu
		    var ul_collasible_body = a_active.closest('.collapsible-body');
		    ul_collasible_body.show();
		    ul_collasible_body.closest('li').addClass('active');
		    ul_collasible_body.closest('li').find('> a').addClass('active');
	    }	   	   
	}
}

var ss_list = {
	wrap_list: '#wrap-list',
	wrap_filter: '#wrap-filter',
	wrap_more_filter: '#wrap-more-filter',
	form: '#form-list-data',
	init: function(){
		var self = this;

		//pagination click
		$(self.form).on('click', '.pagination > li[data-page]:not(.active)', function() {
			var page = typeof($(this).data('page')) != 'undefined' ? parseInt($(this).data('page')) : null;
			if(page == null) return false;
			$(self.form).find('input[name="page"]').val(page);	
			self.loadListData();
		});

		//limit change
		$(self.form).on('change', 'select#limit', function() {
			var limit = typeof($(this).val()) != 'undefined' ? parseInt($(this).val()) : null;
			if(limit == null) return false;
			$(self.form + ' input[name="limit"]').val(limit);
			self.loadListData();
		});

		//search
		$(self.form).on('click', '#filter-data', function() {
			self.loadListData();
		});

		//reset input search
		$(self.form).on('click', '#reset-filter', function() {
			$(self.form).find('input[name="page"]').val(1);
			$(self.wrap_filter).find('input').val('');
			$(self.wrap_filter).find('select').val('').trigger('change');
			self.loadListData();
		});

		// more filter
		$(self.form).on('click', '#more-filter', function() {
			console.log('more');
			console.log(self.wrap_more_filter);
			$(self.wrap_more_filter).find('.collapsible-body').show('slow');
		});

	},
	loadListData: function(){
		var self = this;

		var data = {};
	    var params = {};
	    $.map($(self.form).serializeArray(), function (n, i) {
	        data[n['name']] = $.trim(n['value']);
	        if($.trim(n['value']).length > 0){
	        	params[n['name']] = $.trim(n['value']);
	        }
	    });
	  
	    var url = typeof($(self.form).attr('action')) != 'undefined' ? $(self.form).attr('action') : '';
	    url += url.length > 0 ? '?' + $.param(params) : '';

		ss_backend.callAjax({
			url: url,
			data_type: 'html',
			data: data
		}).done(function(response) {
			$('html, body').animate({
		        scrollTop: $(self.wrap_list).offset().top - 5
		    }, 400);

			$(self.wrap_list).html(response);
			$('select').material_select();
		});
	}
}

$(document).ready(function() {
	// ss_backend.init();
    ss_backend.csrf_token = $('#csrf_token').val();    
    $('#csrf_token').remove();
    ss_backend.activeMenu();
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