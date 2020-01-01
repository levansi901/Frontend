var ss_product_list = {	
	table: '#data-table',
	form: '#form-list-data',
	init: function(){
		var self = this;	
		$('select').material_select();

		$('.auto-numeric').autoNumeric('init', default_option_autonumric);

        $('.input-date-picker').datepicker({
        	dateFormat: 'dd/mm/yyyy',
        	onSelect(formattedDate, date, inst) {
	        	var input = $(inst.el);	        	
	        	if(input.attr('id') == 'create_from'){
	        		var datepicker = $('#create_to').datepicker().data('datepicker');
	        		datepicker.update('minDate', date);
	        	}
	    	}
	    });

		// delete
		$(self.form).on('click', '.delete-selected', function() {
			var ids = [];
			$(self.table + ' .select-record:checked').each(function (i, checkbox) {
				var id = $(this).closest('tr').data('id');
				if(typeof(id) != 'undefined' && parseInt(id) > 0){
					ids.push(id);
				}
		    });

		    if(ids.length == 0){
		    	ss_page.notification({
					type: 'error',
					title: 'Vui lòng chọn một bản ghi'
				});
		    }

		    ss_page.alertWarning({
				title: 'Xóa sản phẩm',
				text: 'Bạn chắc chắn muốn xóa những sản phẩm đã chọn ?'
			}, function(rs){
				ss_page.callAjax({
					url: '/product/delete',
					data:{
						ids: ids
					}
				}).done(function(response) {
					if(typeof(response.success) != 'undefined' && response.success){
						$.each(ids, function(i, product_item_id) {
						  	$(self.table + ' tr[data-id="'+ product_item_id +'"]').remove();
						});

						if($(self.table + ' tr[data-id]').length == 0){
							ss_list.loadListData();
						}
					}	            
				})
			});
		});

		// disable | enable 
		$(self.form).on('click', '.change-status-selected', function() {
			var ids = [];
			var status = typeof($(this).data('status')) != 'undefined' ? parseInt($(this).data('status')) : 1;
			$(self.table + ' .select-record:checked').each(function (i, checkbox) {
				var id = $(this).closest('tr').data('id');
				if(typeof(id) != 'undefined' && parseInt(id) > 0){
					ids.push(id);
				}
		    });

		    if(ids.length == 0){
		    	ss_page.notification({
					type: 'error',
					title: 'Vui lòng chọn một bản ghi'
				});
		    }

		    var icon_status = '<i class="material-icons f-s-18">no_encryption</i>';
		    if(status == 1){
		    	icon_status = '<i class="material-icons f-s-18 text-green">check</i>';
		    }

		    ss_page.alertWarning({
				title: 'Thay đổi trạng thái sản phẩm',
				text: 'Bạn chắc chắn muốn thay đổi trạng thái những sản phẩm đã chọn ?'
			}, function(rs){
				ss_page.callAjax({
					url: '/product/change-status',
					data:{
						ids: ids,
						status: status
					}
				}).done(function(response) {
					if(typeof(response.success) != 'undefined' && response.success){
						$.each(ids, function(i, product_item_id) {
						  	$(self.table + ' tr[data-id="'+ product_item_id +'"] .status-column').html(icon_status);
						});
					}	            
				})
			});
		});

		$(self.form).on('mouseenter', self.table + ' > tbody > tr', function () {
		    var product_id = $(this).data('product-id');
		    $(self.table + ' > tbody > tr[data-product-id=' + product_id + ']').addClass('h');
		});

		$(self.form).on('mouseleave', self.table + ' > tbody > tr', function () {
		    var product_id = $(this).data('product-id');
		    $(self.table + ' > tbody > tr[data-product-id=' + product_id + ']').removeClass('h');
		});

	},
	
}

$(document).ready(function() {
	ss_list.init();
    ss_product_list.init();
});
