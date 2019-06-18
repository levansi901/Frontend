var ss_product = {	
	init: function(){
		var self = this;

		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
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
		can_add: false,
		can_delete: true,
		event: function(){
			var self = this;

			$(self.wrap_items).on('click', '#add-item', function(e) {
				// if(!self.can_add){
				// 	return false;
				// }

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
			            	$('select').material_select();
			            	self.eventNotSync();
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
				$(this).find('.collapsible-header i.index-item').html('filter_' + 1);
			});
		},
		validateItem: function(){
			var self = this;
			var check = true;
			if($(self.wrap_list + ' .collapsible .li-item').length < 1) {
				ss_backend.notification({
					type: 'error',
					title: 'Sản phẩm hiện tại chưa có phiên bản nào'
				});
				check = false;
			}
			return check;
		}	
	},
	product_form: {
		btn_submit: '#btn-submit',
		event: function(){
			var self = this;			

			$(document).on('click', self.btn_submit, function (e) {
				e.stopPropagation();
				var validate = ss_product.item_product.validateItem();

				if (validate) {
		            $('#validation-form').submit();
		        }
			});



			$('#product-form').validate({
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
		        },
		        submitHandler: function (form) {

		            var redirect_page = $('.id-after-save:input[name=after_save]:checked').val();

		            switch (redirect_page) {
		                case 'list':
		                    editAjax(form, "{$url_ajax}", "{$url_redirect}");
		                    break;
		                case 'store':
		                    editAjax(form, "{$url_ajax}", null, function (e) {
		                        window.location.href = '/admin/store/bill/add-supplier?product_id=' + e.id;
		                    });
		                    break;
		                default:
		                    editAjax(form, "{$url_ajax}", 1);
		            }
		        },
		        invalidHandler: function (form) {
		        }
			});
		}
	}
}

$(document).ready(function() {
    ss_product.init();
});
