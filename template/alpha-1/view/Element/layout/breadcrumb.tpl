{assign var=end_bread value=[]}
{if !empty($data)}
    {assign var=end_bread value=$data|@end}
{/if}
<div class="row no-m breadcrumb-header">
    <div class="page-title hide-on-small-and-down">{if !empty($end_bread.title)}{$end_bread.title}{/if}</div>
    <div class="right-align lh-36 f-s-13">
        <a href="/" class="teal-text">Tổng quan</a> 
        <span class="m-l-xxs m-r-xxs">/</span>
        {if !empty($data)}
            {foreach from=$data item=breadcrumb}
                {if !empty($breadcrumb.url)}
                    <a href="{$breadcrumb.url}" class="teal-text">{$breadcrumb.title}</a>    
                    <span class="m-l-xxs m-r-xxs">/</span>
                {else}
                    <span>{$breadcrumb.title}</span>
                {/if}
            {/foreach}
        {/if}
    </div>
</div>
