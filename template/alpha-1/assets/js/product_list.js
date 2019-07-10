var ss_product_list = {	
	init: function(){
		var self = this;	
		$('select').material_select();

		$('.auto-numeric').autoNumeric('init', {
			mDec: 0,
			vMin: 0,
            vMax: 9999999999
        });        

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
	},
	
}

$(document).ready(function() {
	ss_list.init();
    ss_product_list.init();
});
