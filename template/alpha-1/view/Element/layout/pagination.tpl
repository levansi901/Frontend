{if !empty($pagination)}
    {assign var = limit_page value = {$pagination.limit|intval}}
    {assign var = current_page value = {$pagination.page|intval}}
    {assign var = number_page value = {$pagination.pageCount|intval}}
    {assign var = total_record value = {$pagination.count|intval}}
    {assign var = current_record value = {$pagination.current|intval}}

    {assign var = start_page value = 1}
    {assign var = end_page value = $number_page}
    {assign var = start_record value = ($current_page - 1) * $limit_page}
    {assign var = end_record value = $current_record + (($current_page -1) * $limit_page)}

    {if $number_page > 10}
        {if $current_page <= 4}
           {assign var = start_page value = 1}
           {assign var = end_page value = 10}
        {elseif $number_page - $current_page <= 4}    
            {assign var = start_page value = $number_page - 10}
        {else}        
            {assign var = start_page value = ($current_page - 4)}
            {assign var = end_page value = ($current_page + 5)}
        {/if}
    {/if}

    <div class="pagination">
        <span class="count-record"> {$start_record} - {$end_record} / {$total_record} </span>

        {if $current_page != 1}
            <li data-page="1" title="Trang đầu">
                <i class="material-icons">first_page</i>
            </li>
        {/if}

        {for $page = $start_page to $end_page}
            <li data-page="{$page}" class="{if $page == $current_page}active{/if}">
                {$page}
            </li>
        {/for}

        {if $current_page != $number_page}
            <li data-page="{$number_page}" title="Trang cuối">
                <i class="material-icons">last_page</i>
            </li>
        {/if}        
    </div>    
{/if}