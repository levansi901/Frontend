
<!DOCTYPE html>
<html>
<head>
    
    <title>{$title_for_layout}</title>
        
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta charset="UTF-8">
    <meta name="description" content="Responsive Admin Dashboard Template" />
    <meta name="keywords" content="admin,dashboard" />
    <meta name="author" content="Steelcoders" />
        
    <!-- Styles -->
    <link type="text/css" rel="stylesheet" href="/template/alpha-1/assets/plugins/materialize/css/materialize.min.css"/>
    <link href="/template/alpha-1/assets/plugins/material-preloader/css/materialPreloader.min.css" rel="stylesheet">        
        	
    <!-- Theme Styles -->
    <link href="/template/alpha-1/assets/css/alpha.css" rel="stylesheet" type="text/css"/>
    <link href="/template/alpha-1/assets/css/custom.css" rel="stylesheet" type="text/css"/>
        
        
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

        <!-- Javascripts -->
    <script src="/template/alpha-1/assets/plugins/jquery/jquery-2.2.0.min.js"></script>
    <script src="/template/alpha-1/assets/plugins/materialize/js/materialize.min.js"></script>
    <script src="/template/alpha-1/assets/plugins/material-preloader/js/materialPreloader.min.js"></script>
    <script src="/template/alpha-1/assets/plugins/jquery-blockui/jquery.blockui.js"></script>
    <script src="/template/alpha-1/assets/js/alpha.min.js"></script>
    <script src="/template/alpha-1/assets/js/product.js"></script>    
</head>
    
<body>
    {$this->element('layout/pre-loader')}

    <div class="mn-content fixed-sidebar">
        {$this->element('layout/header')}

        {$this->element('layout/left_sidebar',['menus'=> []])}

        <main class="mn-inner">
            <div class="row">
                {$this->fetch('content')}
            </div>
        </main>        
    </div>
    <div class="left-sidebar-hover"></div>


</body>
</html>
