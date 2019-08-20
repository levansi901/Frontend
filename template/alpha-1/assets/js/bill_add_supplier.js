var ss_add_supplier = {
	form: '#bill-form',
	btn_submit: '.btn-submit-form',
	init: function(){
		var self = this;
		ss_page.shortcut();
		ss_bill.init({
			row_template: $('#template-row tbody').html()
		});
		ss_bill.autoSuggestProduct();
		ss_bill.fee_other.event();
		ss_bill.supplier.event();
		
		$('select:not(.select2)').material_select();
		$('.auto-numeric').autoNumeric('init', default_option_autonumric);

		self.validationForm();

		$(document).on('change', '#payment-confirm', function(e) {
			$('#wrap-payment').toggleClass('hide', !$(this).is(':checked'));		
		});

		$(document).on('click', self.btn_submit, function(e) {
			e.preventDefault();

			var step = $(this).data('step');
			if(step != 'undefined'){
				$('#submit_step').val(step);
			}

			if(self.validationForm()){
				self.submitForm();
			}

		});
	},
	validationForm: function(){
		return true;
	},
	submitForm: function(){
		var self = this;
		
		// parse data items
		var data_items = ss_bill.items.getDataItems();
		if(!$.isEmptyObject(data_items)){
			$(self.form).find('#data_items').val(JSON.stringify(data_items));
		}

		ss_page.callAjax({
        	url: '/inventory/save',
        	data: $(self.form).serializeArray()
        }).done(function(response) {
        	
        });
	}
}

$(document).ready(function() {	
    ss_add_supplier.init();
});
