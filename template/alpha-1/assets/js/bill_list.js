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

        var param_supplier_suggest = {
        	input_suggest: '#supplier-suggest',
        	input_value_id: '#supplier_id',
        	url: '/supplier/get/ajax',
        	query: {
        		limit: 10, 
        		get_info: 'simple'
        	}
        };

        ss_page.autoCompleteBasic(param_supplier_suggest);

        var param_user_suggest = {
        	input_suggest: '#created-by-suggest',
        	input_value_id: '#created_by',
        	url: '/user/get/ajax',
            label_field: 'full_name',
        	query: {
        		limit: 10, 
        		get_info: 'simple'
        	}
        };
        ss_page.autoCompleteBasic(param_user_suggest);
	}
}

$(document).ready(function() {
	ss_list.init();
    ss_bill_list.init();
});
