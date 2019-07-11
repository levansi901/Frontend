{assign var=end_bread value=[]}
{if !empty($data)}
    {assign var=end_bread value=$data|@end}
{/if}
<div class="row no-m breadcrumb-header">
    <div class="page-title">{if !empty($end_bread.title)}{$end_bread.title}{/if}</div>
    <div class="right-align lh-30">
        <a href="/">Tổng quan</a> /
        {if !empty($data)}
            {foreach from=$data item=breadcrumb}
                {if !empty($breadcrumb.url)}
                    <a href="{$breadcrumb.url}">{$breadcrumb.title}</a>    
                    /                
                {else}
                    <span>{$breadcrumb.title}</span>
                {/if}
            {/foreach}
        {/if}
    </div>
</div>
