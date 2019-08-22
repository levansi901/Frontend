var ss_bill = {
	table: '#bill-table',
	popover_item: '#popover-item',
	popover_item_content: '',
	popover_discount: '#popover-discount',
	popover_discount_content: '',
	row_template: '',
	type_discount_default: 'MONEY',
	general:{
		total: 0,
		total_quantity: 0,
		discount: 0,
		type_discount: '',
		total_discount: 0,		
		total_other: 0,
		total_vat: 0,
		total_final: 0
	},		
	init: function(params = {}){
		var self = this;

		// get params
		if(typeof(params.row_template) != 'undefined'){
			self.row_template = params.row_template
		}
		self.popover_item_content = $(self.popover_item).html();
		self.popover_discount_content = $(self.popover_discount).html();

		// event
		self.items.event();
		self.discount.event();
			
	},
	calculateTotal: function(){
		var self = this;

		self.general.total = 0;
		self.general.total_quantity = 0;
		self.general.total_discount = 0;		
		self.general.total_other = 0;
		self.general.total_vat = 0;
		self.general.total_final = 0;
		
		// total
		$(self.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
			var price = typeof($(this).find('td[data-price]').attr('data-price')) != 'undefined' ? ss_page.utilities.parseFloat($(this).find('td[data-price]').attr('data-price')) : 0;
			var quantity = typeof($(this).find('td[data-quantity]').attr('data-quantity')) ? ss_page.utilities.parseInt($(this).find('td[data-quantity]').attr('data-quantity')) : 1;
			quantity = quantity >= 1 ? quantity : 1;
			var row_total = price * quantity;
			
			self.general.total_quantity += quantity;		
			self.general.total += row_total;

			// show label row total 
			$(this).find('td[data-row-total]').attr('data-row-total', row_total);
			$(this).find('td[data-row-total]').html(ss_page.utilities.parseNumberToTextMoney(row_total));
		});

		// discount
		self.general.discount = typeof($('#label-total-discount').attr('data-discount')) != 'undefined' ? ss_page.utilities.parseFloat($('#label-total-discount').attr('data-discount')) : 0;
		self.general.type_discount = typeof($('#label-total-discount').attr('data-type-discount')) != 'undefined' ? $('#label-total-discount').attr('data-type-discount') : self.type_discount_default;

		if(self.general.type_discount == 'PERCENT'){
			if(self.general.discount > 100){
				self.general.discount = 0;
				$('#label-total-discount').attr('data-discount', 0);
			}
			self.general.total_discount = parseFloat((self.general.discount * self.general.total) / 100);
		}else{
			self.general.total_discount = self.general.discount;
		}
		
		// other fee
		self.general.total_other = typeof($('#label-total-other').attr('data-total-other')) != 'undefined' ? ss_page.utilities.parseFloat($('#label-total-other').attr('data-total-other')) : 0;

		// calculate final total
		self.general.total_final = self.general.total - self.general.total_discount + self.general.total_other;

		self.general.total_final = self.general.total_final >=0 ? self.general.total_final : 0;

		// set value to label total
		$('#label-total-quantity').attr('data-total-quantity', self.general.total_quantity).text(ss_page.utilities.parseNumberToTextMoney(self.general.total_quantity));
		$('#label-total').attr('data-total', self.general.total).text(ss_page.utilities.parseNumberToTextMoney(self.general.total));
		$('#label-total-discount').attr('data-total-discount', self.general.total_discount).text(ss_page.utilities.parseNumberToTextMoney(self.general.total_discount));
		$('#label-total-vat').attr('data-total-vat', self.general.total_vat).text(ss_page.utilities.parseNumberToTextMoney(self.general.total_vat));
		$('#label-total-final').attr('data-total-final', self.general.total_final).text(ss_page.utilities.parseNumberToTextMoney(self.general.total_final));
	},
	toggleNoRecord: function(show = true){
		var self = this;
		$(self.table).find('tr.no-record').toggleClass('hide', show ? false : true);
	},	
	autoSuggestProduct: function(){
		var self = this;
		$('#auto_suggest_product').autoComplete({
			minChars: 1,
			delay: 300,
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
		        var name = typeof(item.name) != 'undefined' ? item.name : '';
		        var code = typeof(item.code) != 'undefined' ? item.code : '';
		        var id = typeof(item.id) != 'undefined' ? item.id : '';
		        var price = typeof(item.price) != 'undefined' ? ss_page.utilities.parseNumberToTextMoney(item.price) : 0;
		        var quantity = typeof(item.quantity) != 'undefined' ? ss_page.utilities.parseNumberToTextMoney(item.quantity) : 0;

		        return  '<div class="autocomplete-suggestion" data-id="' +  id + '">' +
		        			'<div class="suggestion-content">' +
		        				'<div class="suggestion-content-name">' + name + '</div>' +
		        				'<div class="suggestion-content-code">' + code + '</div>' +
		        			'</div>' +
		        			'<div class="suggestion-price">' +
		        				'<div class="suggestion-content-price"> ' + price + '</div>' +
		        				'<div class="suggestion-content-quantity">Số lượng: ' + quantity + '</div>' +
		        			'</div>' +		        			
		        		'</div>';
		    },
		    onSelect: function(e, term, item){
		    	self.items.loadItemToList({
		    		product_item_id: item.data('id')
		    	});
		    }
		});
	},
	fee_other: {
		total: 0,
		data: [],
		modal: '#modal-fee-other',
		list: '#list-fee-other',
		btn_add: '#btn-add-fee-other',
		btn_save: '#btn-save-fee-other',
		btn_delete: '.delete-fee-other',
		row_template: '',
		event: function(){
			var self = this;
			self.row_template = $(self.list + ' div.row:first-child').length > 0 ? $(self.list + ' div.row:first-child').clone()[0].outerHTML : '';
			var fee_other_info = $('input#fee_other_info').val();
			if(typeof(fee_other_info) != 'undefined' && fee_other_info.length > 0){
				self.data = $.parseJSON(fee_other_info);
			}

			$(document).on('click', '#btn-bill-fee-other', function(e) {
				self.loadList();
				$(self.modal).openModal({
					dismissible: false
				});
			});

			$(self.modal).on('click', self.btn_add, function(e) {
				self.addRow();
			});

			$(self.modal).on('click', self.btn_delete, function(e) {
				$(this).closest('div.row').remove();
				self.calculateFeeOther();
			});

			$(self.modal).on('keyup', 'input.fee-other', function(e) {
				self.calculateFeeOther();
			});

			$(self.modal).on('click', self.btn_save, function(e) {
				self.calculateFeeOther(true);
				$(self.modal).closeModal();
				ss_bill.calculateTotal();
			});
		},
		addRow: function(data = {}){
			var self = this;
			var name = typeof(data.name) != 'undefined' ? data.name : '';
			var fee = typeof(data.fee) != 'undefined' ? ss_page.utilities.parseNumberToTextMoney(data.fee) : '';

			$(self.list).append(self.row_template);
			$(self.list + ' .row:last-child').find('input.name-fee-other').val(name);
			$(self.list + ' .row:last-child').find('input.fee-other').val(fee);
			$(self.list + ' .row:last-child').find('input.auto-numeric').autoNumeric('init', default_option_autonumric);
		},
		calculateFeeOther: function(apply_value = false){
			var self = this;
			self.total = 0;
			self.data = [];
			$(self.list).find('div.row').each(function(index, row) {
				var name = typeof($(this).find('input.name-fee-other').val()) != 'undefined' ? $(this).find('input.name-fee-other').val() : '';
				var fee = typeof($(this).find('input.fee-other').val()) != 'undefined' ? ss_page.utilities.parseTextMoneyToNumber($(this).find('input.fee-other').val()) : 0;
				if(!fee > 0){
					return;				
				}
				
				self.total += fee;

				self.data.push({
					name: name,
					fee: fee
				});
			});

			$(self.modal + ' #label-total-fee-other').text(ss_page.utilities.parseNumberToTextMoney(self.total));

			if(apply_value){			
				$('#label-total-other').text(ss_page.utilities.parseNumberToTextMoney(self.total));
				$('#label-total-other').attr('data-total-other', self.total);
				$('input#fee_other').val(self.total);
				$('input#fee_other_info').val(JSON.stringify(self.data));
			}			
		},
		loadList: function(){
			var self = this;
			$(self.modal + ' ' + self.list).html('');
			if($.isEmptyObject(self.data)){
				self.addRow();
			}else{
				$.each(self.data, function(index, item) {
				  	self.addRow(item);
				});
			}
			
		}
	},
	supplier:{
		modal: '#modal-add-supplier',
		btn_add_supplier: '#btn-add-supplier',
		input_suggest: '#supplier-suggest',
		input: '#supplier_id',
		event: function(){
			var self = this;	

			$(document).on('focus', self.input_suggest, function(e) {
				$(this).select();
			});

			$(document).on('change', self.input_suggest, function(e) {
				$(self.input).val('');
			});
			
			$(document).on('click', '#btn-quick-add-supplier', function(e) {
				self.loadModal();				
			});

			$(self.modal).on('click', self.btn_add_supplier, function(e) {
				ss_page.validation.clearError($(self.modal));

				var input_name_supplier = $(self.modal + ' input#name_supplier');
				var input_address_supplier = $(self.modal + ' input#address_supplier');
				var input_email_supplier = $(self.modal + ' input#email_supplier');
				var input_phone_supplier = $(self.modal + ' input#phone_supplier');

				var name = typeof(input_name_supplier.val()) != 'undefined' ? input_name_supplier.val() : '';
				var address = typeof(input_address_supplier.val()) != 'undefined' ? input_address_supplier.val() : '';
				var email = typeof(input_email_supplier.val()) != 'undefined' ? input_email_supplier.val() : '';
				var phone = typeof(input_phone_supplier.val()) != 'undefined' ? input_phone_supplier.val() : '';

				if(!$.trim(name).length > 0){
					ss_page.validation.showError({
						input_object: input_name_supplier,
						error_message: 'Vui lòng nhập tên nhà cung cấp'
					});
					return false;
				}

				if($.trim(email).length > 0 && !ss_page.validation.isEmail($.trim(email))){
					ss_page.validation.showError({
						input_object: input_email_supplier,
						error_message: 'Email chưa đúng định dạng'
					});
					return false;
				}

				if($.trim(phone).length > 0 && !ss_page.validation.isPhone($.trim(phone))){
					ss_page.validation.showError({
						input_object: input_phone_supplier,
						error_message: 'Số điện thoại chưa đúng định dạng'
					});
					return false;
				}

				if(!$.trim(address).length > 0){
					ss_page.validation.showError({
						input_object: input_address_supplier,
						error_message: 'Vui lòng nhập địa chỉ nhà cung cấp'
					});
					return false;
				}				
	
				var data = {
					name: name,
					address: address,
					email: email,
					phone: phone,
					group_id: typeof($(self.modal + ' select#group_supplier option:selected').val()) != 'undefined' ? $(self.modal + ' select#group_supplier option:selected').val() : '',
					city_id: typeof($(self.modal + ' input#city_id_supplier').val()) != 'undefined' ? $(self.modal + ' input#city_id_supplier').val() : '',
					district_id: typeof($(self.modal + ' input#district_id_supplier').val()) != 'undefined' ? $(self.modal + ' input#district_id_supplier').val() : '',
					city_name: typeof($(self.modal + ' input#city_name_supplier').val()) != 'undefined' ? $(self.modal + ' input#city_name_supplier').val() : '',
					district_name: typeof($(self.modal + ' input#district_name_supplier').val()) != 'undefined' ? $(self.modal + ' input#district_name_supplier').val() : ''
				}

				ss_page.callAjax({
					url: '/supplier/quick-add-supplier',
					data: data
				}).done(function(response) {
					$(self.modal).closeModal();

					var success = typeof(response.success) != 'undefined' ? response.success : false;
					var message = typeof(response.message) != 'undefined' ? response.message : 'Dữ liệu trả về không hợp lệ';
					var supplier_id = typeof(response.data) != 'undefined' ? response.data.id : null;
					if(success){
						$(self.input_suggest).val(name);
						$(self.input).val(supplier_id);
					}else{
						ss_page.notification({
							type: 'error',
					    	title: message
					    });
					}				    				   
				}).fail(function(jqXHR, textStatus, errorThrown) {
					$(self.modal).closeModal();
				    ss_page.notification({
				    	type: 'error',
				    	title: errorThrown
				    });
				});
			});

			$(self.input_suggest).autoComplete({
				minChars: 0,
			    source: function(keyword, suggest){
			    	ss_page.callAjax({
						url: '/supplier/get',
						data:{
							keyword: keyword,
							get_info: 'simple',
							limit: 10
						}
					}).done(function(response) {
					    suggest(response);
					});
			    },
			    renderItem: function (item, search){
			        search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
			        var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
			        var id = typeof(item.id) != 'undefined' ? item.id : '';
			        var name = typeof(item.name) != 'undefined' ? item.name : '';
			        return '<div class="autocomplete-suggestion single-suggestion" data-name="' +  name + '" data-id="' + id + '">' + name.replace(re, "<b>$1</b>") + '</div>';
			    },
			    onSelect: function(e, term, item){
			    	$(self.input_suggest).val(item.data('name'));
			    	$(self.input).val(item.data('id'));
			    }
			});
		},
		loadModal: function(){
			var self = this;
			if(!$(self.modal + ' .modal-content')[0].hasChildNodes()){
				ss_page.callAjax({
					url: '/supplier/view-quick-add-supplier',
					data_type: 'html'
				}).done(function(response) {
					$(self.modal + ' .modal-content').html(response);
					$(self.modal + ' select.select2').select2();
					$(self.modal + ' select:not(.select2)').material_select();
					ss_page.validation.phoneInput();
					ss_page.location.city_district_select.event();

					$(self.modal).openModal({
						dismissible: false
					});
				});
			}else{
				self.clearModal();
				$(self.modal).openModal({
					dismissible: false
				});
			}
		},
		clearModal: function(){
			var self = this;
			ss_page.validation.clearError($(self.modal));

			$(self.modal).find('input').val('');
			$(self.modal).find('select').val('').trigger('change');
		},	
	},
	discount: {
		event: function(){
			var self = this;
			$('#btn-bill-discount').webuiPopover({
				animation: 'pop',
		    	content: ss_bill.popover_discount_content,
		    	onShow: function(element) {
		    		self.onShowPopoverDiscount(element);
		    	},
		    	onHide: function(element) {
		    		self.onHidePopoverDiscount(element);
		    	}
		    });
		},
		onShowPopoverDiscount: function(element = null){
			var self = this;
			var bill_discount = typeof($('#label-total-discount').attr('data-discount')) != 'undefined' ? parseFloat($('#label-total-discount').attr('data-discount')) : 0;
    		var type_discount = typeof($('#label-total-discount').attr('data-type-discount')) != 'undefined' ? $('#label-total-discount').attr('data-type-discount') : ss_bill.type_discount_default;

    		element.find('select#popover-bill-type-discount').val(type_discount);
    		element.find('select#popover-bill-type-discount').material_select();
    		
    		element.find('input#popover-bill-discount').val(ss_page.utilities.parseNumberToTextMoney(bill_discount));
    		element.find('input#popover-bill-discount').autoNumeric('init', default_option_autonumric);
	        element.find('input#popover-item-price').select();

	        element.on('change', 'input#popover-bill-discount, select#popover-bill-type-discount', function(e) {
	        	self.onHidePopoverDiscount(element);
	        });
		},
		onHidePopoverDiscount: function(element = null){
			var bill_discount = typeof(element.find('input#popover-bill-discount')) != 'undefined' ? ss_page.utilities.parseTextMoneyToNumber(element.find('input#popover-bill-discount').val()) : 0;
    		var type_discount = typeof(element.find('select#popover-bill-type-discount')) != 'undefined' ? element.find('select#popover-bill-type-discount').val() : ss_bill.type_discount_default;

    		$('#label-total-discount').attr('data-total-discount', 0);
    		$('#label-total-discount').attr('data-discount', bill_discount);
    		$('#label-total-discount').attr('data-type-discount', type_discount);
    		$('#label-total-discount').text('');
    		$('form input#discount').val(bill_discount);
    		$('form input#type_discount').val(type_discount);
    		ss_bill.calculateTotal();

		}
	},
	items:{
		event: function(){
			var self = this;

			$(ss_bill.table).on('click', '.remove-item', function(e) {
				$(this).closest('tr').remove();
	        	if($(ss_bill.table + 'tbody tr[data-id]').length == 0){
	        		ss_bill.toggleNoRecord(true);
	        	}

	        	ss_bill.calculateTotal();
			});

			$(ss_bill.table).on('keyup', 'tbody td[data-quantity] input#quantity', function(e) {
				var quantity = ss_page.utilities.parseTextMoneyToNumber($(this).val());

				switch(e.which){
					case 38:
						quantity += 1;
						$(this).val(ss_page.utilities.parseNumberToTextMoney(quantity));
						break;
					case 40:
						quantity -= 1;
						$(this).val(ss_page.utilities.parseNumberToTextMoney(quantity));
						break;
				}

				if(!parseInt($(this).val()) > 0){
					quantity = 1;
					$(this).val(quantity);				
				}

				$(this).closest('td[data-quantity]').attr('data-quantity', quantity);
				ss_bill.calculateTotal();
			});	


			$(ss_bill.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
				self.initPopoverPrice($(this));

			});
		},
		loadItemToList: function(params = {}){
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
				$(ss_bill.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
					if($(this).data('id') == data.id){
						var td_quantity = $(this).find('td[data-quantity]');
						var old_quantity = typeof(td_quantity.attr('data-quantity')) != 'undefined' ? parseInt(td_quantity.attr('data-quantity')) : 1;
						td_quantity.attr('data-quantity', old_quantity + 1);
						td_quantity.find('input#quantity').val(ss_page.utilities.parseNumberToTextMoney(old_quantity + 1));
						has_item = true;
						return false;
					}
				});

				if(has_item){
					return false;
				}
				
				// add item to table
			    $(ss_bill.table + ' > tbody').prepend(ss_bill.row_template);
			    
			    // fill data to row
			    var tr = $(ss_bill.table + ' tbody > tr:first-child');
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
			    	td_name.html(data.name);
			    }

			    if(typeof(data.price) != 'undefined'){
			    	var td_price = tr.find('td[data-price]');
			    	td_price.attr('data-price', data.price);
			    	td_price.attr('data-price-before', data.price);
			    	td_price.find('input#price').val(ss_page.utilities.parseNumberToTextMoney(data.price));		    			   
			    }  

			    ss_bill.toggleNoRecord(false);
			    ss_bill.calculateTotal();					   		  

			    self.initPopoverPrice(tr);

			    // focus input quantity
			    tr.find('td[data-quantity] input#quantity').focus().select();
			    
			});
		},
		getDataItems: function(){
			var data =[];
			$(ss_bill.table + ' > tbody').find('tr:not(.no-record)').each(function(index, tr) {
				var item = {
					product_item_id: typeof($(this).data('id')) != 'undefined' ? ss_page.utilities.parseInt($(this).data('id')) : null,
					price: typeof($(this).find('td[data-price]').attr('data-price')) != 'undefined' ? ss_page.utilities.parseFloat($(this).find('td[data-price]').attr('data-price')) : 0,					
					vat: typeof($(this).find('td[data-vat]').attr('data-vat')) != 'undefined' ? ss_page.utilities.parseInt($(this).find('td[data-vat]').attr('data-vat')) : 0,
					type_discount: typeof($(this).find('td[data-discount-type]').attr('data-discount-type')) != 'undefined' ? $(this).find('td[data-discount-type]').attr('data-discount-type') : ss_bill.type_discount_default,
					discount: typeof($(this).find('td[data-discount]').attr('data-discount')) != 'undefined' ? ss_page.utilities.parseInt($(this).find('td[data-discount]').attr('data-discount')) : 0,
					quantity: typeof($(this).find('td[data-quantity]').attr('data-quantity')) != 'undefined' ? ss_page.utilities.parseInt($(this).find('td[data-quantity]').attr('data-quantity')) : 1
				};
				data.push(item);
			});
			return data;
		},
		initPopoverPrice: function(tr = null){
			var self = this;
			if(tr.length > 0){
				tr.find('input#price').webuiPopover({
			    	animation: 'pop',
			    	content: ss_bill.popover_item_content,
			    	onShow: function(element) {		    		
			    		self.onShowPopoverPrice(tr, element);
			    	},
			    	onHide: function(element) {
			    		self.onHidePopoverPrice(tr, element);
			    	}
			    });
			}
		},
		onShowPopoverPrice: function(tr = null, element = null){
			var self = this;
			var price_before = typeof(tr.find('td[data-price-before]').attr('data-price-before')) != 'undefined' ? parseFloat(tr.find('td[data-price-before]').attr('data-price-before')) : 0;
    		var type_discount = typeof(tr.find('td[data-discount-type]')) != 'undefined' ? tr.find('td[data-discount-type]').attr('data-discount-type') : ss_bill.type_discount_default;
    		var discount_value = typeof(tr.find('td[data-discount-value]')) != 'undefined' ? parseFloat(tr.find('td[data-discount-value]').attr('data-discount-value')) : 0;
    		var vat = typeof(tr.find('td[data-vat]')) != 'undefined' ? parseFloat(tr.find('td[data-vat]').attr('data-vat')) : 0;
    		element.find('input#popover-item-price').val(ss_page.utilities.parseNumberToTextMoney(price_before));
	
    		element.find('input#popover-item-discount').val(ss_page.utilities.parseNumberToTextMoney(discount_value));
    		element.find('select#popover-item-type-discount').val(type_discount);

    		element.find('input#popover-item-vat').val(ss_page.utilities.parseNumberToTextMoney(vat));

    		element.find('.auto-numeric').autoNumeric('init', default_option_autonumric);
	        element.find('input#popover-item-price').select();
	        element.find('select:not(.select2)').material_select();

	        element.on('change', 'input#popover-item-price, input#popover-item-discount, input#popover-item-vat, select#popover-item-type-discount', function(e) {
	        	self.onHidePopoverPrice(tr, element);
	        });
		},
		onHidePopoverPrice: function(tr = null, element = null){
			var price = typeof(element.find('input#popover-item-price')) != 'undefined' ? ss_page.utilities.parseTextMoneyToNumber(element.find('input#popover-item-price').val()) : 0;
    		var vat = typeof(element.find('input#popover-item-vat')) != 'undefined' ? ss_page.utilities.parseTextMoneyToNumber(element.find('input#popover-item-vat').val()) : 0;
    		var discount_value = typeof(element.find('input#popover-item-discount')) != 'undefined' ? ss_page.utilities.parseTextMoneyToNumber(element.find('input#popover-item-discount').val()) : 0;			    		
    		var type_discount = typeof(element.find('select#popover-item-type-discount').val()) != 'undefined' ? element.find('select#popover-item-type-discount').val() : ss_bill.type_discount_default;
			var discount = 0;
			var price_before = price;
			if(type_discount == 'PERCENT'){
				if(discount_value > 100){
					discount_value = 0;
					element.find('input#popover-item-discount').val(0);
				}
				discount = parseFloat((discount_value * price) / 100);
			}else{
				discount = discount_value;
			}
			price -= discount;
			price = price >=0 ? price : 0;
			
    		tr.find('td[data-price]').attr('data-price', price);
    		tr.find('td[data-price-before]').attr('data-price-before', price_before);
    		tr.find('td[data-price] input#price').val(ss_page.utilities.parseNumberToTextMoney(price));

    		tr.find('td[data-discount]').attr('data-discount', discount);
    		tr.find('td[data-discount-value]').attr('data-discount-value', discount_value);
    		tr.find('td[data-discount-type]').attr('data-discount-type', type_discount);

    		tr.find('td[data-vat]').attr('data-vat', vat);

    		ss_bill.calculateTotal();
		}
	}
}
