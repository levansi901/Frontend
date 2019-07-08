var ss_product_list = {	
	init: function(){
		var self = this;	

		$('select').material_select();

		// $('.auto-numeric').autoNumeric('init', {
		// 	  mDec: 0,
		// 	  vMin: 0,
  //           vMax: 9999999999
  //       });        

     //    $('.input-date-picker').datepicker({
     //    	timepicker: true,
     //    	onSelect(formattedDate, date, inst) {
	    //     	var input = $(inst.el);	        	
	    //     	if(input.data('name') == 'item-time-start'){
	    //     		var input_time_end = input.closest('.li-item').find('input[data-name="item-time-end"]');
	    //     		var datepicker = input_time_end.datepicker().data('datepicker');
	    //     		datepicker.update('minDate', date);
	    //     	}
	    // 	}
	    // });
	},
	
}

$(document).ready(function() {
	ss_list.init();
    ss_product_list.init();
});
