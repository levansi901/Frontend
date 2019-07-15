var ss_add_supplier = {	
	form: '#bill-form',	
	init: function(){
		var self = this;

		$('select').material_select();

		self.autoSuggest();
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
	},
	autoSuggest: function(){
		var self = this;
		$('#filter_product').autoComplete({
		    source: function(keyword, suggest){
		    	ss_backend.callAjax({
					url: '/product/item/get',
					data:{
						keyword: keyword
					}
				}).done(function(response) {
				    suggest(response);
				});
		    },
		    renderItem: function (item, search){
		        search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
		        var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
		        var name = typeof(item.name) != 'undefined' ? item.name : '';
		        return '<div class="autocomplete-suggestion" data-name="' +  name + '">' + name.replace(re, "<b>$1</b>") + '</div>';
		    },
		    onSelect: function(e, term, item){
		    	// $('#filter_product').val(item.data('name'));		
		    	console.log(item);
		    	self.loadDataToList();
		    }
		});
	},
	loadDataToList: function(params){
		var id = typeof(params.id) != 'undefined' ? parseInt(params.id) : null;
		if(!id > 0){
			ss_backend.notification({
				type: 'error',
				title: 'ID sản phẩm không hợp lệ'
			});
			return false;
		}
		
		ss_backend.callAjax({
			url: '/product/item/get',
			data:{
				keyword: keyword
			}
		}).done(function(response) {
		    suggest(response);
		});
	}
}

$(document).ready(function() {
    ss_add_supplier.init();
});
