var ss_bill_list = {	
	table: '#data-table',
	form: '#form-list-data',
	init: function(){
		var self = this;	
		$('select').material_select();

		$('.auto-numeric').autoNumeric('init', default_option_autonumric);        

        $('.input-date-picker').datepicker({
        	timepicker: true,
        	onSelect(formattedDate, date, inst) {
	        	var input = $(inst.el);	        	
	        	if(input.attr('id') == 'create_from'){
	        		var datepicker =  $('#create_to').datepicker().data('datepicker');
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

	},
	
}

$(document).ready(function() {
	ss_list.init();
    ss_bill_list.init();
});
