var ss_add_supplier = {	
	table: '#bill-table',
	init: function(){
		var self = this;

		ss_bill_calculate.init({
			row_template: $('#template-list tbody').html()
		});
	
		$('select').material_select();
		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
        });

		$('.my-button').webuiPopover({url:'#popover-item'});
	},
}

$(document).ready(function() {
    ss_add_supplier.init();
});
