var ss_add_supplier = {	
	table: '#bill-table',
	init: function(){
		var self = this;

		ss_bill.init({
			row_template: $('#template-row tbody').html()
		});
		ss_bill.autoSuggest();
	
		$('select').material_select();
		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
        });
	},
}

$(document).ready(function() {
    ss_add_supplier.init();
});
