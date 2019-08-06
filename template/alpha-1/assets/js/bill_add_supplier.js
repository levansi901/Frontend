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

		$(document).on('click', self.btn_submit, function(e) {
			e.stopPropagation();

			var step = $(this).data('step');
			if(step != 'undefined'){
				$('#submit_step').val(step);
			}

			var check = self.validationForm();
			if (check) {
	            $(self.form).submit();
	        }

		});
	},
	validate: {
		validateForm: function(){
			var self = this;
			
			$(self.form).validate({
				focusInvalid: true,
				messages: {
		                        
	        	},
	        	highlight: function (e) {	
		        },
		        success: function (e) {		           
		        },
		        errorPlacement: function (error, element) {
		        	element.after(error);
		        },
		        submitHandler: function (this_form) {
		            var redirect_page = '';
		            var after_save = $('input[name="after_save"]:checked').val();
		            switch(after_save){
		            	case 'list':
			            	redirect_page = '/product'
			            	break;
		            	case 'edit':
		            		redirect_page = '/product/edit/'
		            		break;
		            	case 'add':
		            		redirect_page = '/product/add'
		            		break;
		            }

		            ss_page.ajaxSubmitForm({
		            	url: $(self.form).attr('action'),
		            	data: new FormData(this_form),
		            	url_redirect: redirect_page,
		            	after_save: after_save
		            });		            
		        },
		        invalidHandler: function (form) {
		        }
			});
		}
	}
}

$(document).ready(function() {	
    ss_add_supplier.init();
});
