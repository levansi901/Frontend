var lazada_category = {
	csrf_token: null,
	modal: $('#modal-lazada-category'),
	lazada_category_id:[],
	init: function(params) {
		var self = this;
		self.csrf_token = typeof(params['csrf_token']) != 'undefined' ? params['csrf_token'] : null;
		$('#lazada_category_id').on('click',function() {
			self.getListCategoriesLazada({
				'list_category_ids': [0]
			},function(categories) {
				self.removeGroupByLevel(0);
				self.loadListCategoriesLazada({
					categories: categories,
				});
			});

	        $('#modal-lazada-category').openModal();
	    });
	},
	removeGroupByLevel: function(level){
		var self = this;
		var level = typeof(level) ? parseInt(level) : 0;
		self.modal.find('.group-level .group-wrap').slice(level, 5).remove();
	},
	loadListCategoriesLazada: function(params) {
		var self = this;
		var categories = typeof(params['categories']) != 'undefined' ? params['categories'] : [];
		var html = '';
		if(!$.isEmptyObject(categories)){
			html += 	'<div class="group-wrap">' +
						'<div class="search-wrap">' + 
		            		'<div class="input-field row no-m">' + 
		                		'<input type="text" class="no-m" maxlength="100" autocomplete="off" placeholder="Tìm danh mục" value="">' +
		            		'</div>' +
		        		'</div>' +
		        		'<ul class="list-wrap">';               						
							$.each(categories, function( index, group) {
							  	if(!$.isEmptyObject(group)){
							  		$.each(group, function( index, category) {
							  			html += '<li>' +
				                    				'<span class="text">' + category.name + '</span>' +
				                    					'<i class="nav-drop-icon material-icons">keyboard_arrow_right</i>' +
				                				'</li>';
							  		});
							  	}
							});						
			html += 	'</ul>' + 
					'</div>';
		}
		self.modal.find('.group-level').append(html);	
	},
	getListCategoriesLazada: function(params, callback) {
		var self = this;

		if (typeof(callback) != 'function') {
	        callback = function () {};
	    }

		var list_category_ids = typeof(params['list_category_ids']) != 'undefined' ? params['list_category_ids'] : null;
		$.ajax({
			headers: {
		        'X-CSRF-Token': self.csrf_token
		    },
	        type: 'POST',
	        url: '/lazada/category/get-list-lazada-categories',
	        data: {
	        	list_category_ids: list_category_ids
	        },
	        dataType: 'JSON',
	        success: function (response) {
	            callback(response);
	        },
	        error: function () {
	            
	        }
	    });
	}
}
