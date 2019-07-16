var ss_add_supplier = {	
	form: '#bill-form',
	table: '#item-table',
	row_template: '',
	init: function(){
		var self = this;
		self.row_template = $('#template-list tr:first-child').clone().html();
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
		    	ss_page.callAjax({
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
		        var code = typeof(item.code) != 'undefined' ? item.code : '';
		        var id = typeof(item.id) != 'undefined' ? item.id : '';
		        var price = typeof(item.price) != 'undefined' ? ss_page.parseNumberToTextMoney(item.price) : 0;
		        var quantity = typeof(item.quantity) != 'undefined' ? ss_page.parseNumberToTextMoney(item.quantity) : 0;

		        return  '<div class="autocomplete-suggestion" data-id="' +  id + '">' +
		        			'<div class="suggestion-content">' +
		        				'<div class="suggestion-content-name">' + name.replace(re, "<b>$1</b>") + '</div>' +
		        				'<div class="suggestion-content-code">' + code + '</div>' +
		        			'</div>' +
		        			'<div class="suggestion-price">' +
		        				'<div class="suggestion-content-price"> ' + price + '</div>' +
		        				'<div class="suggestion-content-quantity">Số lượng: ' + quantity + '</div>' +
		        			'</div>' +		        			
		        		'</div>';
		    },
		    onSelect: function(e, term, item){
		    	self.loadDataToList({
		    		product_item_id: item.data('id')
		    	});
		    }
		});
	},
	loadDataToList: function(params){
		var self = this;
		var product_item_id = typeof(params.product_item_id) != 'undefined' ? parseInt(params.product_item_id) : null;
		if(!product_item_id > 0){
			ss_page.notification({
				
				title: 'ID sản phẩm không hợp lệ'
			});
			return false;
		}
		
		ss_page.callAjax({			
			url: '/product/item/get',
			data:{
				product_item_id: product_item_id
			}
		}).done(function(response) {
		    console.log(response);
		    $(self.table).append(self.row_template);
		    self.toggleNoRecord(false);
		});
	},
	toggleNoRecord: function(show){
		var self = this;
		$(self.table).find('tr.no-record').toggleClass('hide', show ? false : true);
	}
}

$(document).ready(function() {
    ss_add_supplier.init();
});
