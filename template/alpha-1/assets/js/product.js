var ss_product = {
	init: function(params = {}){
		var self = this;
		
        self.item_product.event();
        self.product_form.event();
        self.lazada_category.event();
        self.lazada_brand.event();

		$('select').material_select();

		$('.auto-numeric').autoNumeric('init', default_option_autonumric);        

        $('.input-date-picker').datepicker({
        	timepicker: true,
        	dateFormat: 'dd/mm/yyyy',
        	onSelect(formattedDate, date, inst) {
	        	var input = $(inst.el);
	        	if(input.data('name') == 'item-time_start_discount'){
	        		var input_time_end = input.closest('.li-item').find('input[data-name="item-time_end_discount"]');
	        		var datepicker = input_time_end.datepicker().data('datepicker');
	        		datepicker.update('minDate', date);
	        	}
	    	}
	    });

        var filemanager_access_key = $('#filemanager_access_key').val();
	    ss_page.tinyMce({
	    	filemanager_access_key: typeof(filemanager_access_key) != 'undefined' ? filemanager_access_key : null
	    });	    
	},
	item_product: {
		form: '#product-form',
		wrap_items: '#wrap-items',
		wrap_list: '#list-items',
		items_deleted: [],
		item_html: '',
		can_add: false,
		can_delete: true,
		index_select_image: null,
		event: function(){
			var self = this;

			self.item_html = $(self.wrap_list + ' > .li-item:first-child')[0].outerHTML;
			var item_id = typeof($(self.form).data('id')) != 'undefined' ? $(self.form).data('id') : null;
			
			var active_index = 0;
			if(item_id > 0){
				active_index = $(self.wrap_list).find('li[data-item-id='+ item_id +']').data('index');
			}

			self.activeItem(active_index > 0 ? active_index : 0);				
			self.checkConditions();

			$(self.wrap_items).on('click', '#add-item', function(e) {
				// if(!self.can_add){
				// 	return false;
				// }
				self.addNewItem();
			});			

			$(self.wrap_list).on('keyup', 'input[data-name="item-code"]', function() {
				$(this).closest('.li-item').find('.title-item').html($.trim($(this).val()));
			});

			$(self.wrap_list).on('click', '.delete-item', function(e) {
				e.stopPropagation();

				self.checkConditions();
				if(!self.can_delete){
					return false;
				}
				var index = $(this).closest('.li-item').index();
				self.removeItem(index);			
			});

			$(self.wrap_list + ' .btn-select-image').fancybox({
	            closeExisting: true,
	            iframe : {
	                preload : false
	            }
	        });

	        $(self.wrap_list).on('click', '.btn-select-image', function(e) {
	        	var index = $(this).closest('li.li-item').data('index');	        	
				self.index_select_image = typeof(index) != 'undefined' ? index : null;
	        	$(window).on('message', OnMessage);
	        });

			$(self.wrap_list).on('click', '.input-select-image', function(e) {				
				var wrap_item = $(this).closest('.input-field').find('.btn-select-image').trigger('click');
			});

			$(self.wrap_list).on('click', '.delete-item-image', function(e) {
				var wrap_image = $(this).closest('.item-image');
				
				var index_image = wrap_image.index();
				var item_id = $(this).closest('li.li-item').data('item-id');
				
				var params = {
					index_image: typeof(index_image) != 'undefined' ? index_image : null,
					item_id: typeof(item_id) != 'undefined' ? item_id : null,
				}
				
				ss_page.alertWarning({
					title: 'Xóa ảnh sản phẩm',
					text: 'Bạn chắc chắn muốn xóa ảnh này ?'
				}, function(rs){
					ss_page.callAjax({
						url: '/product/delete/image',
						data: params
					}).done(function(response) {
						if(typeof(response.success) != 'undefined' && response.success){
							wrap_image.remove();
						}
					});					
				});
				return false;
			});
		},
		eventNewItem: function(){
			var self = this;

			$(self.wrap_list + ' .li-item:last-child select').material_select();

			$(self.wrap_list + ' .li-item:last-child .auto-numeric').autoNumeric('init', default_option_autonumric);

	        $(self.wrap_list + ' .li-item:last-child .input-date-picker').datepicker({
	        	timepicker: true,
	        	onSelect(formattedDate, date, inst) {
	        	var input = $(inst.el);	        	
		        	if(input.data('name') == 'item-time_start_discount'){
		        		var input_time_end = input.closest('.li-item').find('input[data-name="item-time_end_discount"]');
		        		var datepicker = input_time_end.datepicker().data('datepicker');
		        		datepicker.update('minDate', date);
		        	}
		    	}
		    });

		    $(self.wrap_list + ' .btn-select-image').fancybox({
	            closeExisting: true,
	            iframe : {
	                preload : false
	            }
	        });
		},
		checkConditions: function(){
			var self = this;

			// check can delete
			self.can_delete = true; 
			if($(self.wrap_list + ' .li-item').length <= 1){
				self.can_delete = false;
			}

			$(self.wrap_list).find('.li-item .delete-item').toggleClass('hide', !self.can_delete);
		},
		validateItem: function(){
			var self = this;
			if($(self.wrap_list + ' .li-item').length < 1) {
				ss_page.notification({
					type: 'error',
					title: 'Sản phẩm hiện tại chưa có phiên bản nào'
				});
				return false;
			}

			var check = true;
			var all_code = [];
			var all_item = [];
			$(self.wrap_list + ' .li-item').each(function(index, li_item) {
				var li_index = $(this).data('index');
				var input_code = $(this).find('input[data-name="item-code"]');
				var input_price = $(this).find('input[data-name="item-price"]');
				var input_price_discount = $(this).find('input[data-name="item-price-discount"]');

				var code = typeof(input_code.val()) != 'undefined' ? $.trim(input_code.val()) : '';
				var price = typeof(input_price.val()) != 'undefined' ? parseFloat($.trim(input_price.val().replaceAll(',', ''))) : 0;
				var price_discount = typeof(input_price_discount.val()) != 'undefined' ? parseFloat($.trim(input_price_discount.val().replaceAll(',', ''))) : 0;
				var property = '';

				$(this).find('.lazada-sku-attributes select').each(function(idx, input) {	
					console.log(input);			
				});
				
				if(code.length == 0){
					ss_page.validation.showError({
						input_object: input_code,
						error_message: 'Mã sản phẩm không được để trống'
					});					
					check = false;
					self.activeItem(li_index);	
					return check;
				}

				if(price_discount > price){
					ss_page.validation.showError({
						input_object: input_price_discount,
						error_message: 'Giá khuyến mãi không thể lớn hơn giá bán'
					});
					check = false;
					self.activeItem(li_index);	
					return check;
				}
				
				all_code.push(code);

			});

			return check;
		},
		resetIndexItem: function(){
			var self = this;
			$(self.wrap_list + ' .li-item').each(function(i, li_item) {
				self.setIndexItem(i);
			});
		},
		activeItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .li-item[data-index="'+ index +'"]');
			if(typeof(li_item) != 'undefined'){
				li_item.addClass('active');
				li_item.find('.collapsible-header').addClass('active');
				li_item.find('.collapsible-body').show();
			}		
		},
		clearInputItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .li-item:eq('+ index +')');
			if(li_item == 'undefined'){
				return false;
			}

			li_item.find('input').val('');
			li_item.find('select option:first').prop('selected', 'selected').trigger('change');
			li_item.find('.title-item').html('');		
		},
		setIndexItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .li-item:eq('+ index +')');
			
			li_item.attr('data-index', index);
			li_item.find('.collapsible-header i.index-item').html('filter_' + (index + 1));
			li_item.find('input[data-name], select[data-name]').each(function(idx, input) {
				var id = $(this).data('name')+ '-' + index;
				var name = typeof($(this).data('name').split('-')[1]) != 'undefined' ? $(this).data('name').split('-')[1] : '';

				$(this).attr('id', id);
				$(this).attr('name', 'items[' + index + '][' + name +']');
				if(typeof($(this).data('lazada-type')) != 'undefined' && $(this).data('lazada-type') == 'sku'){
					$(this).attr('name', 'items[' + index + '][lazada_item_attributes][' + name +']');
				}
				
				$(this).next('label').attr('for', id).toggleClass('active', $(this).val().length > 0 ? true : false);
			});
		},
		addNewItem: function(){
			var self = this;
			$(self.wrap_list).append(self.item_html);
			var index = $(self.wrap_list + ' .li-item:last-child').index();

			var li_item = $(self.wrap_list + ' .li-item:eq('+ index +')');
			if(li_item.data('item-id') > 0){
				li_item.find('.preview-item-images').remove();
			}
			
			self.clearInputItem(index);
			self.setIndexItem(index);		
			self.activeItem(index);			
			self.eventNewItem();			
		},
		removeItem: function(index){
			var self = this;
			var li_item = $(self.wrap_list + ' .li-item[data-index="'+ index +'"]');
			ss_page.alertWarning({
				title: 'Xóa phiên bản sản phẩm',
				text: 'Bạn chắc chắn muốn xóa phiên bản này ?'
			}, function(rs){		
				var item_id = li_item.data('item-id');						
				if(item_id > 0){
					self.items_deleted.push(item_id);
				}
				li_item.remove();
				self.resetIndexItem();
				self.checkConditions();
			});
		},
		callbackSelectImage: function(e){
			var self = this;

			var event = e.originalEvent;     
		   	if(event.data.sender === 'responsivefilemanager'){          		       
		        var url = event.data.url;

		        if($.isArray(url)){
		            url = JSON.stringify(url);
		        }

		        if(self.index_select_image != null){
		        	$('#item-images-' + self.index_select_image).val(url).trigger('change');	
		        }
		        
		        $.fancybox.close();
		        $(window).off('message', OnMessage);
		   	}
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
		            var redirect_page = '';
		            var after_save = $('input[name="after_save"]:checked').val();
		            switch(after_save){
		            	case 'list':
			            	redirect_page = '/product'
			            	break;
		            	case 'edit':
		            		redirect_page = '/product/edit/'
		            		break;
		            	case 'add':
		            		redirect_page = '/product/add'
		            		break;
		            }
	
		            ss_page.ajaxSubmitForm({
		            	url: $(self.form).attr('action'),
		            	data: new FormData(this_form),
		            	url_redirect: redirect_page,
		            	after_save: after_save
		            });		            
		        },
		        invalidHandler: function (form) {
		        }
			});
		},
	},
	lazada_category: {
		modal: '#modal-lazada-category',
		btn_select: '#select-lazada-category',
		tree_category_id:[],
		lazada_category_id: null,
		lazada_category_id_selected: null,
		event: function(){
			var self = this;
			
	        $('#select_lazada_category').on('click',function() {	

				self.lazada_category_id = $('#lazada_category_id').val().length > 0 ? parseInt($('#lazada_category_id').val()) : null;
				self.tree_category_id = $('#lazada_category_tree_ids').val().length > 0 ? $.parseJSON($('#lazada_category_tree_ids').val()) : [];
				self.lazada_category_id_selected = $('#select_lazada_category').val().length > 0 ? parseInt($('#select_lazada_category').val()) : null;
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

				if(parseInt(self.lazada_category_id) == parseInt(self.lazada_category_id_selected) && self.tree_category_id.length > 0){
					$(self.modal).closeModal();
					return false;
				}

				$('#lazada_category_id').val(self.lazada_category_id);
				$('#lazada_category_tree_ids').val(JSON.stringify(self.tree_category_id));
				$('#select_lazada_category').val(self.getTreeNameCategoriesLazada());	
				$('#select_lazada_category').next('label').addClass('active');
				$(self.modal).closeModal();

				ss_page.callAjax({
					url: '/product/lazada/load-attributes',
					data_type: 'html',
					data:{
						lazada_category_id: self.lazada_category_id,
						type: 'sku'
					}
				}).done(function(response) {
				    $(ss_product.item_product.wrap_list).find('.li-item').each(function(index, li) {
				    	$(this).find('.lazada-sku-attributes').html(response);				    	
				    	var index = $(this).index();
						ss_product.item_product.setIndexItem(index);		            			            	
		            });
		            
		            if(response.length > 0){
		            	ss_product.item_product.item_html = $(ss_product.item_product.wrap_list + ' > .li-item:first-child')[0].outerHTML;
		            	$('.lazada-sku-attributes select').material_select();
		            	ss_product.item_product.can_add = true;
		            }else{
		            	ss_product.item_product.can_add = false;
		            }
				}).fail(function(jqXHR, textStatus, errorThrown) {
				    ss_page.notification({
				    	type: 'error',
				    	title: errorThrown
				    });
				});

				ss_page.callAjax({
					url: '/product/lazada/load-attributes',
					data_type: 'html',
					data:{
						lazada_category_id: self.lazada_category_id,
						type: 'spu'
					}
				}).done(function(response) {
				    $('.lazada-spu-attributes').html(response);
		            $('.lazada-spu-attributes select').material_select();
		            $('#wrap-lazada-spu-attributes').toggleClass('hide', response.length > 0 ? false : true);
				}).fail(function(jqXHR, textStatus, errorThrown) {
				    ss_page.notification({
				    	type: 'error',
				    	title: errorThrown
				    });
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

			ss_page.callAjax({
				url: '/lazada/category/get',
				data:{
					tree_category_id: tree_category_id,
		        	parent_id: parent_id
				}
			}).done(function(response) {
			    callback(response);
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
		},
		getTreeNameCategoriesLazada: function(){
			var self = this;
			var tree_name = [];
			
			$(self.modal).find('.list-wrap li.selected').each(function(index, li) {
				var name = $(this).find('span.text').text();
				if(name != 'undefined' && name.length > 0){
					tree_name.push(name);	
				}				
			});
			return tree_name.length > 0 ? tree_name.join(' → ') : '';
		}
	},
	lazada_brand:{
		input: '#lazada_brand',
		event: function(){
			var self = this;

			$(self.input).autoComplete({
			    source: function(keyword, suggest){
			    	ss_page.callAjax({
						url: '/lazada/brand/get',
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
			        return '<div class="autocomplete-suggestion" data-name="' +  name + '">' + name.replace(re, "<b>$1</b>") + '</div>';
			    },
			    onSelect: function(e, term, item){
			    	$(self.input).val(item.data('name'));
			    }
			});
		},
	}
}

function OnMessage(e){
	ss_product.item_product.callbackSelectImage(e);
}

$(document).ready(function() {
    ss_product.init();
});