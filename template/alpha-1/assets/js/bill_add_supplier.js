var ss_add_supplier = {	
	form: '#bill-form',
	table: '#item-table',
	row_template: '',
	init: function(){
		var self = this;
		self.row_template = $('#template-list tbody').html();
		$('select').material_select();

		self.autoSuggest();
		$('.auto-numeric').autoNumeric('init', {
            mDec: 0,
            vMin: 0,
            vMax: 9999999999
        });
	},
	autoSuggest: function(){
		var self = this;
		$('#filter_product').autoComplete({
			minChars: 1,
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
				type: 'error',
				title: 'ID sản phẩm không hợp lệ'
			});
			return false;
		}
		
		ss_page.callAjax({			
			url: '/product/item/get',
			data:{
				product_item_id: product_item_id
			}
		}).done(function(item) {
			
			var data = typeof(item[0]) != 'undefined' ? item[0] : [];
			if($.isEmptyObject(data)){	
				ss_page.notification({
					type: 'error',
					title: 'Không lấy được thông tin sản phẩm'
				});
				return false;
			}

			// check this item has exist in list
			var has_item = false;
			$(self.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
				if($(this).data('id') == data.id){
					var td_quantity = $(this).find('td[data-quantity]');
					var old_quantity = typeof(td_quantity.attr('data-quantity')) != 'undefined' ? parseInt(td_quantity.attr('data-quantity')) : 1;
					td_quantity.attr('data-quantity', old_quantity + 1);
					td_quantity.find('input#quantity').val(ss_page.parseNumberToTextMoney(old_quantity + 1));
					has_item = true;
					return false;
				}
			});

			if(has_item){
				return false;
			}

			self.toggleNoRecord(false);
		    $(self.table + ' > tbody').prepend(self.row_template);

		    var tr = $(self.table + ' tbody > tr:first-child');
		    // fill data to row
		    if(typeof(data.id) != 'undefined'){
		    	tr.attr('data-id', data.id);			    	
		    }

		    if(typeof(data.code) != 'undefined'){
		    	var td_code = tr.find('td[data-code]');
		    	td_code.attr('data-code', data.code);
		    	td_code.html(data.code);
		    }

		    if(typeof(data.name) != 'undefined'){
		    	var td_name = tr.find('td[data-name]');
		    	td_name.attr('data-name', data.name);
		    	td_name.html(data.code);
		    }

		    if(typeof(data.price) != 'undefined'){
		    	var td_price = tr.find('td[data-price]');
		    	td_price.attr('data-price', data.price);
		    	td_price.find('input#price').val(ss_page.parseNumberToTextMoney(data.price));

		    	var td_row_total = tr.find('td[data-row-total]');
		    	td_row_total.attr('data-row-total', data.price);
		    	td_row_total.html(ss_page.parseNumberToTextMoney(data.price));
		    }
					   		   
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
