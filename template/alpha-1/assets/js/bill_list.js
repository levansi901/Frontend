var ss_bill_list = {	
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

	},
	
}

$(document).ready(function() {
	ss_list.init();
    ss_bill_list.init();
});
