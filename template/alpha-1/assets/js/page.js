String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

var ss_page = {
	csrf_token: null,
	init: function(){
		var self = this;
		self.csrf_token = $('#csrf_token').val();    
    	$('#csrf_token').remove();

    	self.activeMenu();
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
	    		ss_page.notification({
			    	type: 'error',
			    	title: errorThrown
			    });
	    	}			
		});
	    return ajax;
	},
	parseNumberToTextMoney: function(number){
		if (typeof(number) == 'undefined') number = '';
    	return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
	},
	parseTextMoneyToNumber: function(text_number){
		if (typeof(text_number) != 'number' || isNaN(text_number) || typeof(text_number) == 'undefined') {
	        return 0;
	    }
		return number = parseFloat(text_number.toString().replace(/,/g, ''));
	}

}

var ss_list = {
	wrap_list: '#wrap-list',
	wrap_filter: '#wrap-filter',
	wrap_more_filter: '#wrap-more-filter',
	form: '#form-list-data',
	table: '#data-table',
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

		//more filter
		$(self.form).on('click', '#more-filter', function() {
			self.toggleMoreFilter();
		});

		//sort data table
		$(self.form).on('click', 'th.sorting, th.sorting_asc, th.sorting_desc', function() {
			var sort = $(this).data('sort');
			var direction = '';
			if(sort == 'undefined'){
				return false;
			}

			var type_sort = '';
			if($(this).hasClass('sorting')){
				type_sort = 'sorting';		
			}

			if($(this).hasClass('sorting_asc')){
				type_sort = 'asc';
			}

			if($(this).hasClass('sorting_desc')){
				type_sort = 'desc';
			}

			$(self.table).find('th[data-sort]').removeClass('sorting_asc sorting_desc').addClass('sorting');
			switch(type_sort){
				case 'sorting':
				case 'desc':
					$(this).removeClass('sorting').addClass('sorting_asc');
					direction = 'asc';
					break;
				case 'asc':
					$(this).removeClass('sorting').addClass('sorting_desc');
					direction = 'desc';
					break;
			}

			$(self.form).find('input[name="sort"]').val(sort);
			$(self.form).find('input[name="direction"]').val(direction);

			self.loadListData();
		});

		//check all
		$(self.form).on('change', '#select-all', function() {
			$(self.table).find('.select-record').prop('checked', $(this).is(":checked"));			
			self.toggleShowActionList($(this).is(":checked"));
		});

		//checkbox change
		$(self.form).on('change', 'input.select-record', function() {
			if($(this).is(":checked") && $(self.table + ' input.select-record:checked').length == 1){
				self.toggleShowActionList(true);
			}

			if(!$(this).is(":checked") && $(self.table + ' input.select-record:checked').length == 0){
				self.toggleShowActionList(false);
			}
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

		ss_page.callAjax({
			url: url,
			data_type: 'html',
			data: data
		}).done(function(response) {
			$('html, body').animate({
		        scrollTop: $(self.wrap_list).offset().top - 5
		    }, 400);

			$(self.wrap_list).html(response);
			$('select').material_select();
			$('.dropdown-button').dropdown();
		});
	},
	toggleMoreFilter: function(){
		var self = this;
		var is_show = false;
		var icon = '';
		if(!$(self.wrap_more_filter).find('.collapsible-body').is(':hidden')){
			is_show = true;
		}

		if(is_show){
			icon = 'keyboard_arrow_down';
			$(self.wrap_more_filter).find('.collapsible-body').hide();
		}else{
			$(self.wrap_more_filter).find('.collapsible-body').show();
			icon = 'keyboard_arrow_up';
		}

		$(self.form).find('#more-filter i').text(icon);
		$(self.wrap_more_filter).toggleClass('active');
	},
	toggleShowActionList: function(show){
		var self = this;
		if(show){
			$(self.table).find('thead > tr > th:not(:first-child)').addClass('hide-text');
			$(self.table).find('thead > tr > th > #wrap-action-list').removeClass('hide');
		}else{
			$(self.table).find('thead > tr > th:not(:first-child)').removeClass('hide-text');
			$(self.table).find('thead > tr > th > #wrap-action-list').addClass('hide');
		}		
	}
}

var ss_bill_calculate = {
	table: '#bill-table',
	row_template: null,
	items: [],
	total: 0,
	total_discount: 0,
	total_coupon: 0,
	total_voucher: 0,
	total_vat: 0,
	total_final: 0,
	init: function(params){
		var self = this;

		// get params
		if(typeof(params.row_template) != 'undefined'){
			self.row_template = params.row_template
		}

		self.autoSuggest();

		$(self.table).on('click', '.remove-item', function(e) {
			$(this).closest('tr').remove();
        	if($(self.table + 'tbody tr[data-id]').length == 0){
        		self.toggleNoRecord(true);
        	}
		});

		$(self.table).on('change', 'tbody td[data-quantity] input#quantity', function(e) {
			var quantity = $(this).val();
			if(!parseInt(quantity) > 0){
				quantity = 1;
				$(this).val(1);
			}
			$(this).closest('td[data-quantity]').attr('data-quantity',quantity);
			self.calculateTotal();
		});
		
	},
	calculateTotal: function(){
		var self = this;

		$(self.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
			var id = typeof($(this).data('id')) != 'undefined' ? $(this).data('id') : null;
			var price = typeof($(this).find('td[data-price]').attr('data-price')) != 'undefined' ? $(this).find('td[data-price]').attr('data-price') : 0;
			var quantity = typeof($(this).find('td[data-quantity]').attr('data-quantity')) ? $(this).find('td[data-quantity]').attr('data-quantity') : 1;
			var row_total = parseInt(price) * parseInt(quantity);
				
			self.total += row_total;

			// show label row total 
			$(this).find('td[data-row-total]').attr('data-row-total', row_total);
			$(this).find('td[data-row-total]').html(ss_page.parseNumberToTextMoney(row_total));
		});

	},
	toggleNoRecord: function(show){
		var self = this;
		$(self.table).find('tr.no-record').toggleClass('hide', show ? false : true);
	},
	autoSuggest: function(){
		var self = this;
		$('#filter_product').autoComplete({
			minChars: 1,
			delay: 300,
		    source: function(keyword, suggest){
		    	ss_page.callAjax({
					url: '/product/item/get',
					data:{
						keyword: keyword
					}
				}).done(function(response) {
				    suggest(response);
				});
		    },
		    renderItem: function (item, search){
		        search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
		        var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
		        var name = typeof(item.name) != 'undefined' ? item.name : '';
		        var code = typeof(item.code) != 'undefined' ? item.code : '';
		        var id = typeof(item.id) != 'undefined' ? item.id : '';
		        var price = typeof(item.price) != 'undefined' ? ss_page.parseNumberToTextMoney(item.price) : 0;
		        var quantity = typeof(item.quantity) != 'undefined' ? ss_page.parseNumberToTextMoney(item.quantity) : 0;

		        return  '<div class="autocomplete-suggestion" data-id="' +  id + '">' +
		        			'<div class="suggestion-content">' +
		        				'<div class="suggestion-content-name">' + name.replace(re, "<b>$1</b>") + '</div>' +
		        				'<div class="suggestion-content-code">' + code + '</div>' +
		        			'</div>' +
		        			'<div class="suggestion-price">' +
		        				'<div class="suggestion-content-price"> ' + price + '</div>' +
		        				'<div class="suggestion-content-quantity">Số lượng: ' + quantity + '</div>' +
		        			'</div>' +		        			
		        		'</div>';
		    },
		    onSelect: function(e, term, item){
		    	self.loadDataToList({
		    		product_item_id: item.data('id')
		    	});
		    }
		});
	},
	loadDataToList: function(params){
		var self = this;
		var product_item_id = typeof(params.product_item_id) != 'undefined' ? parseInt(params.product_item_id) : null;
		if(!product_item_id > 0){
			ss_page.notification({
				type: 'error',
				title: 'ID sản phẩm không hợp lệ'
			});
			return false;
		}
		
		ss_page.callAjax({			
			url: '/product/item/get',
			data:{
				product_item_id: product_item_id
			}
		}).done(function(item) {			
			var data = typeof(item[0]) != 'undefined' ? item[0] : [];
			if($.isEmptyObject(data)){	
				ss_page.notification({
					type: 'error',
					title: 'Không lấy được thông tin sản phẩm'
				});
				return false;
			}

			// check this item has exist in list
			var has_item = false;
			$(self.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
				if($(this).data('id') == data.id){
					var td_quantity = $(this).find('td[data-quantity]');
					var old_quantity = typeof(td_quantity.attr('data-quantity')) != 'undefined' ? parseInt(td_quantity.attr('data-quantity')) : 1;
					td_quantity.attr('data-quantity', old_quantity + 1);
					td_quantity.find('input#quantity').val(ss_page.parseNumberToTextMoney(old_quantity + 1));
					has_item = true;
					return false;
				}
			});

			if(has_item){
				return false;
			}
			
			// add item to table
		    $(self.table + ' > tbody').prepend(self.row_template);
		    
		    // fill data to row
		    var tr = $(self.table + ' tbody > tr:first-child');
		    if(typeof(data.id) != 'undefined'){
		    	tr.attr('data-id', data.id);			    	
		    }

		    if(typeof(data.code) != 'undefined'){
		    	var td_code = tr.find('td[data-code]');
		    	td_code.attr('data-code', data.code);
		    	td_code.html(data.code);
		    }

		    if(typeof(data.name) != 'undefined'){
		    	var td_name = tr.find('td[data-name]');
		    	td_name.attr('data-name', data.name);
		    	td_name.html(data.name);
		    }

		    if(typeof(data.price) != 'undefined'){
		    	var td_price = tr.find('td[data-price]');
		    	td_price.attr('data-price', data.price);
		    	td_price.find('input#price').val(ss_page.parseNumberToTextMoney(data.price));		    			   
		    }		   		  

		    self.toggleNoRecord(false);
		    self.calculateTotal();					   		  

		    // focus input quantity
		    tr.find('td[data-quantity] input#quantity').focus().select();
		});
	}
}

$(document).ready(function() {
	ss_page.init();
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