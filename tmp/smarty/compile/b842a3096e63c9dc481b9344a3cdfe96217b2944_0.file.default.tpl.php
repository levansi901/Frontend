<?php
/* Smarty version 3.1.33, created on 2019-06-05 09:48:42
  from 'D:\Work\NhanHoa\SaleSupport\Frontend\template\alpha-1\view\Layout\default.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.33',
  'unifunc' => 'content_5cf78ffac069e1_11449915',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b842a3096e63c9dc481b9344a3cdfe96217b2944' => 
    array (
      0 => 'D:\\Work\\NhanHoa\\SaleSupport\\Frontend\\template\\alpha-1\\view\\Layout\\default.tpl',
      1 => 1559727527,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5cf78ffac069e1_11449915 (Smarty_Internal_Template $_smarty_tpl) {
?>
<!DOCTYPE html>
<html>
<head>
    
    <title>Alpha | Responsive Admin Dashboard Template</title>
        
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta charset="UTF-8">
    <meta name="description" content="Responsive Admin Dashboard Template" />
    <meta name="keywords" content="admin,dashboard" />
    <meta name="author" content="Steelcoders" />
        
    <!-- Styles -->
    <link type="text/css" rel="stylesheet" href="template/alpha-1/assets/plugins/materialize/css/materialize.min.css"/>
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="template/alpha-1/assets/plugins/material-preloader/css/materialPreloader.min.css" rel="stylesheet">        

        	
    <!-- Theme Styles -->
    <link href="template/alpha-1/assets/css/alpha.css" rel="stylesheet" type="text/css"/>
    <link href="template/alpha-1/assets/css/custom.css" rel="stylesheet" type="text/css"/>
        
        
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <?php echo '<script'; ?>
 src="http://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="http://oss.maxcdn.com/respond/1.4.2/respond.min.js"><?php echo '</script'; ?>
>
    <![endif]-->
</head>
    
<body>
    <?php echo $_smarty_tpl->tpl_vars['this']->value->element('layout/pre-loader');?>


    <div class="mn-content fixed-sidebar">
        <?php echo $_smarty_tpl->tpl_vars['this']->value->element('layout/header');?>


        <?php echo $_smarty_tpl->tpl_vars['this']->value->element('layout/left_sidebar',array('menus'=>array()));?>


        <main class="mn-inner">
            <div class="row">
                <?php echo $_smarty_tpl->tpl_vars['this']->value->fetch('content');?>

            </div>
        </main>        
    </div>
    <div class="left-sidebar-hover"></div>

    <!-- Javascripts -->
    <?php echo '<script'; ?>
 src="template/alpha-1/assets/plugins/jquery/jquery-2.2.0.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="template/alpha-1/assets/plugins/materialize/js/materialize.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="template/alpha-1/assets/plugins/material-preloader/js/materialPreloader.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="template/alpha-1/assets/plugins/jquery-blockui/jquery.blockui.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="template/alpha-1/assets/js/alpha.min.js"><?php echo '</script'; ?>
>
</body>
</html>
<?php }
}
