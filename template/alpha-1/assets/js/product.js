var lazada_category = {
	modal: '#modal-lazada-category',
	tree_category_id:[],
	lazada_category_id: null,
	init: function(params) {
		var self = this;

		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
        });
		
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

		$(self.modal).on('click', '#btn-selected', function() {
			$('#lazada_category_id').val(self.data.lazada_category_id);
			$('#lazada_category_tree_ids').val(JSON.parse(self.data.lazada_category_tree_ids));
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
		        'X-CSRF-Token': workspace.csrf_token
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
		$(self.modal).find('#btn-selected').toggleClass('disabled', self.lazada_category_id > 0 ? false : true);
	}
}

$(document).ready(function() {
    lazada_category.init(); 
});
