var ss_product = {	
	init: function(){
		var self = this;

		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
        });

        tinymce.init({
		    selector: '.mce-editor'
		});

        $('.input-date-picker').datepicker({
        	timepicker: true
	    });

        self.lazada_category.event();
        self.item_product.event();
        self.product_form.event();
	},
	lazada_category: {
		modal: '#modal-lazada-category',
		btn_select: '#select-lazada-category',
		tree_category_id:[],
		lazada_category_id: null,	
		event: function(){
			var self = this;
	        $('#select_lazada_category').on('click',function() {		
				self.lazada_category_id = $('#lazada_category_id').val().length > 0 ? parseInt($('#lazada_category_id').val()) : null;
				self.tree_category_id = $.trim($('#lazada_category_tree_ids').val()).length > 0 ? $.parseJSON($.trim($('#lazada_category_tree_ids').val())) : [];				
				self.removeGroupByLevel(0);
				self.toggleDisableSelectedButton();
				var params = { 
					parent_id: 0 
				};

				if(!$.isEmptyObject(self.tree_category_id)){
					params = {
						tree_category_id: self.tree_category_id 
					}
				}
				
				self.getListCategoriesLazada(params,function(categories) {				
					self.loadListCategoriesLazada({
						categories: categories,
						level: 0
					});
				});

		        $(self.modal).openModal();
		    });

			$(self.modal).on('click', '.list-wrap > li', function() {
				$(this).closest('.list-wrap').find('li').removeClass('selected');
				$(this).addClass('selected');

				self.lazada_category_id = null;
			  	var level = typeof($(this).closest('.group-wrap').data('level')) != 'undefined' ? $(this).closest('.group-wrap').data('level') : 0;
				var lazada_category_id = typeof($(this).data('id')) != 'undefined' ? parseInt($(this).data('id')) : null;
				self.setValueTreeId({
					level: level,
					lazada_category_id: lazada_category_id
				});
				self.removeGroupByLevel(level);		

				if($(this).data('final')){	
					self.lazada_category_id = lazada_category_id;
				}else{
					self.getListCategoriesLazada({
						'parent_id': lazada_category_id
					},function(categories) {				
						self.loadListCategoriesLazada({
							categories: categories,
							level: level
						});
					});
				}

				self.toggleDisableSelectedButton();
			});

			$(self.modal).on('keyup', '.search-wrap input', function() {
				var keyword =  $.trim($(this).val()).length > 0 ? $.trim($(this).val()).toLowerCase() : '';
				var list_wrap = $(this).closest('.group-wrap').find('.list-wrap');
				list_wrap.find('li').removeClass('hide');
				
				if(list_wrap.find('li').length > 0 && keyword.length > 0){				
					list_wrap.find('span.text').each(function(index) {
					  	var title = $(this).attr('title') !='undefined' ? $(this).attr('title').toLowerCase() : '';				  		  
					  	if(title.indexOf(keyword) == -1){
					  		$(this).closest('li').addClass('hide');
					  	}
					});
				}
			});

			$(self.modal).on('click', self.btn_select, function() {
				if($(this).hasClass('disabled')){
					return false;
				}

				$('#lazada_category_id').val(self.lazada_category_id);
				$('#lazada_category_tree_ids').val(JSON.stringify(self.tree_category_id));
				$(self.modal).closeModal();			

				$.ajax({
					async: true,
					headers: {
				        'X-CSRF-Token': ss_backend.csrf_token
				    },
			        type: 'POST',
			        url: '/product/item/sku-attributes/load',
			        data: {
			        	lazada_category_id: $('#lazada_category_id').val(),
			        },
			        dataType: 'html',
			        success: function (response) {	        	
			            $(ss_product.item_product.wrap_list).find('.li-item').each(function() {
			            	$(this).find('.sku-attributes').html(response);
			            });
			            if(response.length > 0){
			            	$('select').material_select();
			            	ss_product.item_product.can_add = true;
			            }else{
			            	ss_product.item_product.can_add = false;
			            }
			            
			        },
			        error: function () {
			            
			        }
			    });
			});
		},
		removeGroupByLevel: function(level){
			var self = this;
			var level = typeof(level) != 'undefined' ? parseInt(level) : 0;
			$(self.modal).find('.group-level .group-wrap').slice(level, 10).remove();
		},
		getListCategoriesLazada: function(params, callback) {
			var self = this;

			if (typeof(callback) != 'function') {
		        callback = function () {};
		    }

			var tree_category_id = typeof(params['tree_category_id']) != 'undefined' ? params['tree_category_id'] : null;
			var parent_id = typeof(params['parent_id']) != 'undefined' ? params['parent_id'] : null;
			$.ajax({
				async:true,
				headers: {
			        'X-CSRF-Token': ss_backend.csrf_token
			    },
		        type: 'POST',
		        url: '/lazada/category/get-list-lazada-categories',
		        data: {
		        	tree_category_id: tree_category_id,
		        	parent_id: parent_id
		        },
		        dataType: 'JSON',
		        success: function (response) {
		            callback(response);
		        },
		        error: function () {
		            
		        }
		    });
		},
		loadListCategoriesLazada: function(params) {
			var self = this;
			var level = typeof(params['level']) != 'level' ? parseInt(params['level']) : 0;
			var categories = typeof(params['categories']) != 'undefined' ? params['categories'] : [];
			var html = '';
			if(!$.isEmptyObject(categories)){
				$.each(categories, function(index, group) {
					var current_id = typeof(self.tree_category_id[index]) != 'undefined' ? self.tree_category_id[index] : null;
					html += '<div class="group-wrap" data-level="' + (level + 1) + '">' +
								'<div class="search-wrap">' + 
				            		'<div class="input-field row no-m">' + 
				                		'<input type="text" class="no-m" maxlength="100" autocomplete="off" placeholder="Tìm danh mục" value="">' +
				            		'</div>' +
				        		'</div>' +
				        		'<ul class="list-wrap">';               														
								  	if(!$.isEmptyObject(group)){
								  		$.each(group, function(index, category) {
								  			var icon = '';
								  			if(!category.final){
								  				icon = '<i class="material-icons right">keyboard_arrow_right</i>';
								  			}
								  			var selected = '';
								  			if(current_id == category.lazada_category_id){
								  				selected = 'selected';
								  			}
								  			html += '<li class="'+ selected +'" data-id="'+ category.lazada_category_id +'" data-final="' + category.final + '">' + 
					                    				'<span class="text" title="' + category.name + '">' + category.name + '</span>' + icon
					                				'</li>';
								  		});
								  	}
					html += 	'</ul>' + 
							'</div>';

					level++;
				});
			}
			$(self.modal).find('.group-level').append(html);	
		},
		setValueTreeId: function(params){
			var self = this;
			var level = typeof(params.level) != 'undefined' ? parseInt(params.level) : 1;
			var lazada_category_id = typeof(params.lazada_category_id) != 'undefined' ? parseInt(params.lazada_category_id) : null;
			self.tree_category_id.slice(level - 1, 10);
			self.tree_category_id.push(lazada_category_id);		
		},
		toggleDisableSelectedButton: function(){
			var self = this;
			$(self.modal + ' ' + self.btn_select).toggleClass('disabled', self.lazada_category_id > 0 ? false : true);
		}
	},
	item_product: {
		wrap_items: '#wrap-items',
		wrap_list: '#list-items',
		items_deleted: [],
		item_html: '',
		can_add: false,
		can_delete: true,
		event: function(){
			var self = this;

			self.item_html = $(self.wrap_list + ' > ul.collapsible > .li-item:first-child')[0].outerHTML;
			console.log(self.item_html);
			self.activeItem(0);

			$(self.wrap_items).on('click', '#add-item', function(e) {
				// if(!self.can_add){
				// 	return false;
				// }
				var wrap = $(self.wrap_list + ' > ul.collapsible');
				var item_html = wrap.find('.li-item:first-child')[0].outerHTML;
				console.log(item_html);
				wrap.append(item_html);
				var index = $(self.wrap_list + ' > ul.collapsible > .li-item:last-child').index();
				self.clearInputItem(index);
				self.activeItem(index);
				self.resetIndexItem();
				// console.log(item_html);
				return false;
				var number = $(self.wrap_list).find('.collapsible > li.li-item').length > 0 ? parseInt($(self.wrap_list).find('.collapsible > li.li-item').length) + 1 : 1;

				$.ajax({
					async: true,
					headers: {
				        'X-CSRF-Token': ss_backend.csrf_token
				    },
			        type: 'POST',
			        url: '/product/item/add',
			        data: {
			        	lazada_category_id: $('#lazada_category_id').val(),
			        	number: number
			        },
			        dataType: 'html',
			        success: function (response) {
			            $(self.wrap_list).find('.collapsible').append(response);            			            
			            if(response.length > 0){
			            	self.activeItem($(self.wrap_list).find('.li-item').length - 1);
			            	$('select').material_select();
			            	self.eventNotSync();
			            	$('.input-date-picker').datepicker({
					        	timepicker: true
						    });			            	
			            }			            	
			        },
			        error: function () {
			        }
			    });
			});			

			$(self.wrap_items).on('keyup', 'input[data-name="item-code"]', function() {
				$(this).closest('.li-item').find('.title-item').html($.trim($(this).val()));
			});

			self.eventNotSync();
		},
		eventNotSync: function(){
			var self = this;
			$('.collapsible .delete-item').on('click', function(e) { 
				e.stopPropagation();
				if(!self.can_delete){
					return false;
				}

				var li_item = $(this).closest('.li-item');				
				ss_backend.alertWarning({
					title: 'Xóa phiên bản sản phẩm',
					text: 'Bạn chắc chắn muốn xóa phiên bản này ?'
				}, function(rs){		
					var item_id = li_item.find('#item_id');						
					if(item_id > 0){
						self.items_deleted.push(item_id);
					}
					li_item.remove();
					self.resetIndexItem();
					self.checkConditions();
				});
			});
		},
		checkConditions: function(){
			var self = this;

			// check can delete
			if($(self.wrap_list).find('.collapsible > .li-item').length == 1){
				self.can_delete = false;
			}
			$(self.wrap_list).find('.collapsible .li-item .delete-item').toggleClass('hide', !self.can_delete);
		},
		resetIndexItem: function(){
			var self = this;
			$(self.wrap_list + ' .collapsible .li-item').each(function(i, li_item) {
				$(this).attr('data-index', i);
				$(this).find('.collapsible-header i.index-item').html('filter_' + (i + 1));
				$(this).find('input[data-name]').each(function(idx, input) {
					var id = $(this).data('name')+ '-' + i;
					$(this).attr('id', id);
					$(this).next('label').attr('for', id).toggleClass('active',$(this).val().length > 0 ? true : false);
				});
			});
		},
		activeItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .collapsible .li-item[data-index="'+ index +'"]');
			if(typeof(li_item) != 'undefined'){
				li_item.addClass('active');
				li_item.find('.collapsible-header').addClass('active');
				li_item.find('.collapsible-body').show();
			}		
		},
		validateItem: function(){
			var self = this;
			if($(self.wrap_list + ' .collapsible .li-item').length < 1) {
				ss_backend.notification({
					type: 'error',
					title: 'Sản phẩm hiện tại chưa có phiên bản nào'
				});
				return false;
			}

			$(self.wrap_list + ' .collapsible .li-item').each(function(index, li_item) {
				var li_index = $(this).data('index');
				var input_code = $(this).find('input[data-name="item-code"]');
				var input_price = $(this).find('input[data-name="item-price"]');
				var input_price_discount = $(this).find('input[data-name="item-price-discount"]');

				var code = typeof(input_code.val()) != 'undefined' ? $.trim(input_code.val()) : '';
				var price = typeof(input_price.val()) != 'undefined' ? parseFloat($.trim(input_price.val().replaceAll(',', ''))) : 0;
				var price_discount = typeof(input_price_discount.val()) != 'undefined' ? parseFloat($.trim(input_price_discount.val().replaceAll(',', ''))) : 0;

				if(code.length == 0){
					ss_backend.showValidateError({
						input_object: input_code,
						error_message: 'Mã sản phẩm không được để trống'
					});
					self.activeItem(li_index);
					return false;
				}

				if(price_discount > price){
					ss_backend.showValidateError({
						input_object: input_price_discount,
						error_message: 'Giá khuyến mãi không thể lớn hơn giá bán'
					});
					return false;
				}
				
			});

			return true;
		},
		clearInputItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .li-item:eq('+ index +')');
			if(li_item == 'undefined'){
				return false;
			}

			li_item.find('input').val('');
			// li_item.find('select option:first').val(null).trigger('change');
			li_item.find('select option:first').prop('selected', 'selected').trigger('change');
		}
	},
	product_form: {
		btn_submit: '.btn-submit-form',
		form: '#product-form',
		event: function(){
			var self = this;			

			self.validationForm();


			$(document).on('click', self.btn_submit, function (e) {
				e.stopPropagation();
				var check = ss_product.item_product.validateItem();
				if (check) {
		            $(self.form).submit();
		        }
			});

		},
		validationForm: function(){
			var self = this;
			
			$(self.form).validate({
				focusInvalid: true,
				messages: {
		            'name': {
		                required: 'Vui lòng nhập tên sản phẩm'
		            },	            
	        	},
	        	highlight: function (e) {	
		        },
		        success: function (e) {		           
		        },
		        errorPlacement: function (error, element) {
		        	element.after(error);
		        },
		        submitHandler: function (this_form) {
		        	// console.log(new FormData(this_form));
		        	// return false;
		            var redirect_page = $('.id-after-save:input[name=after_save]:checked').val();
		            // console.log($(this_form).serialize());
		            ss_backend.ajaxSubmitForm({
		            	url: $(self.form).attr('action'),
		            	type: $(self.form).attr('method'),
		            	data: new FormData(this_form)
		            });
		            
		        },
		        invalidHandler: function (form) {
		        }
			});
		},
	}
}

$(document).ready(function() {
    ss_product.init();
});
