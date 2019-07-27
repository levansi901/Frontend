var ss_add_supplier = {	
	table: '#bill-table',
	init: function(){
		var self = this;

		ss_bill.init({
			row_template: $('#template-row tbody').html()
		});
		ss_bill.autoSuggest();
		ss_bill.fee_other.event();

		$('select').material_select();
		$('.auto-numeric').autoNumeric('init', default_option_autonumric);
	},
}

$(document).ready(function() {
    ss_add_supplier.init();
});
