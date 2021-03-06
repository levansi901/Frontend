
<!DOCTYPE html>
<html>
<head>
    
    <title>{$title_for_layout}</title>
        
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta charset="UTF-8">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="" />
        
    {if !empty($css_layout)}
        {foreach from = $css_layout item = list_css_file}
            {foreach from = $list_css_file item = css_file}
                <link rel="stylesheet" type="text/css" href="/template/alpha-1/{$css_file}"/>
            {/foreach}
        {/foreach}
    {/if}
            
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    {if !empty($js_layout)}
        {foreach from=$js_layout item = list_js_file}
            {foreach from = $list_js_file item = js_file}
                <script type="text/javascript" src="/template/alpha-1/{$js_file}"></script>
            {/foreach}
        {/foreach}
    {/if}    
</head>
    
<body url-reference="{if isset($url_reference)}{$url_reference}{/if}">
    {$this->element('layout/pre-loader')}

    <div class="mn-content fixed-sidebar">

        {$this->element('layout/header')}

        {$this->element('layout/left_sidebar',['menus'=> []])}

        <main class="mn-inner">
            {$this->fetch('content')}
        </main>        
    </div>
    <div class="left-sidebar-hover"></div>
    <input type="hidden" id="csrf_token" value="{if !empty($csrf_token)}{$csrf_token}{/if}">
    <input type="hidden" id="filemanager_access_key" value="{if !empty($filemanager_access_key)}{$filemanager_access_key}{/if}" />
    <input type="hidden" id="cdn_url" value="{if !empty($cdn_url)}{$cdn_url}{/if}" />
</body>
</html>
