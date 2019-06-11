var product_form = {
	csrf_token: null,
	lazada_category_id:[],
	init: function(params) {
		var self = this;
		self.csrf_token = typeof(params['csrf_token']) != 'undefined' ? params['csrf_token'] : null;
		console.log(self.csrf_token);
		$('#lazada_category_id').on('click',function() {
			self.getListCategoriesLazada({
				'list_category_ids':0
			},function(categories) {
				console.log(categories);
				self.loadListCategoriesLazada({
					categories: categories
				});
			});

	        $('#modal-lazada-category').openModal();
	    });
	},
	loadListCategoriesLazada: function(params) {
		var level = typeof(params['level']) != 'undefined' ? params['level'] : 0;
		var categories = typeof(params['categories']) != 'undefined' ? params['categories'] : 0;
		console.log(categories);
	},
	getListCategoriesLazada: function(params, callback) {
		var self = this;

		if (typeof(callback) != 'function') {
	        callback = function () {};
	    }

		var list_category_ids = typeof(params['list_category_ids']) != 'undefined' ? params['list_category_ids'] : null;
		console.log(list_category_ids);
		$.ajax({
			headers: {
		        'X-CSRF-Token': self.csrf_token
		    },
	        type: 'POST',
	        url: '/lazada/category/get-list-lazada-categories',
	        data: {
	        	list_category_ids: list_category_ids
	        },
	        success: function (response) {
	            callback(response);
	        },
	        error: function () {
	            
	        }
	    });
	}
}
