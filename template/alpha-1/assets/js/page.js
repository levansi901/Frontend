var workspace ={
	csrf_token: null
}

$(document).ready(function() {
    workspace.csrf_token = $('#csrf_token').val();
});