var ss_add_supplier = {	
	init: function(){
		var self = this;

		$('select').material_select();

		// $('.auto-numeric').autoNumeric('init', {
  //           mDec: 0,
  //           vMin: 0,
  //           vMax: 9999999999
  //       });        

  //       $('.input-date-picker').datepicker({
  //       	timepicker: true,
  //       	onSelect(formattedDate, date, inst) {
	 //        	var input = $(inst.el);	        	
	 //        	if(input.data('name') == 'item-time_start_discount'){
	 //        		var input_time_end = input.closest('.li-item').find('input[data-name="item-time_end_discount"]');
	 //        		var datepicker = input_time_end.datepicker().data('datepicker');
	 //        		datepicker.update('minDate', date);
	 //        	}
	 //    	}
	 //    });
	}
}

$(document).ready(function() {
    ss_add_supplier.init();
});
