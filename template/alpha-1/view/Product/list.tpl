<div class="card-content">      
    <div class="s12">
        <a href="/product/add" class="waves-effect waves-light btn m-b-xs" title="Thêm sản phẩm mới">
            <i class="material-icons left">add</i>
            Thêm sản phẩm mới
        </a>                
    </div>
    
    <table id="data-table" class="display responsive-table custom-table">
        <thead>
            <tr>
                <th class="w-3">
                    <input id="check-all" type="checkbox" class="filled-in no-text"/>
                    <label for="check-all"></label>
                </th>
                <th class="w-3">
                    <i class="material-icons f-s-22">photo_library</i>
                </th>
                <th class="w-30 sorting" data-sort="name">Tên sản phẩm</th>
                <th class="w-15"> 
                    Thuộc tính
                </th>

                <th class="w-15"> 
                    Mã
                </th>

                <th class="w-15 sorting" data-sort="price"> 
                    Giá
                </th>

                <th class="w-15 sorting" data-sort="price" title="Giá khuyến mãi"> 
                    Giá KM
                </th>
                <th>Tồn</th>
                <th class="w-3">TT</th>
                <th class="w-3">
                    <i class="material-icons f-s-22">settings_applications</i>
                </th>
            </tr>
        </thead>
        <tbody>                    
            {if !empty($products)}
                {foreach from = $products key = k_product item = product}
                    {assign var=url_edit value ="/product/edit-product/{$product.id}"}
                    {assign var=rowspan value ={sizeof($product.items)}}
                    {if empty(($k_product + 1) % 2)}
                        {assign var = tr_class value = 'even'}
                    {else}
                        {assign var = tr_class value = 'odd'}
                    {/if}
                    <tr class="{$tr_class}">
                        <td class="center" rowspan="{$rowspan}">
                            <input id="row-{$k_product}" type="checkbox" class="filled-in no-text"/>
                            <label for="row-{$k_product}"></label>                              
                        </td>

                        <td rowspan="{$rowspan}" class="center">
                            <a class="btn btn-xxs blue-grey darken-4 btn-small">
                                <i class="material-icons f-s-22">photo_camera</i>
                            </a>                                    
                        </td>

                        <td rowspan="{$rowspan}">
                            {if !empty($product.name)}
                                {$product.name}
                            {/if}
                        </td>

                        <td>
                            
                        </td>

                        <td class="center">
                            {if !empty($product.items.0.code)}
                                {$product.items.0.code}
                            {/if}
                        </td>

                        <td class="center">
                            {if !empty((float)$product.items.0.price)}
                                {$product.items.0.price|number_format:0:",":","}
                            {/if}
                        </td>
                        <td class="center">
                            {if !empty((float)$product.items.0.price_discount)}
                                {$product.items.0.price_discount|number_format:0:",":","}
                            {/if}
                        </td>

                        <td class="center">
                            
                        </td>

                        <td class="center">
                            {if !empty($product.items.0.status)}
                                <i class="material-icons f-s-14 text-green">check</i>
                            {else}
                                <i class="material-icons f-s-14">no_encryption</i>
                            {/if}
                        </td>

                        <td rowspan="{$rowspan}" class="center">
                            <a class="dropdown-button btn btn-xxs blue-grey darken-4 btn-small " href="#" data-activates="setting-{$k_product}">
                                <i class="material-icons">settings</i>
                            </a>
                            <ul id="setting-{$k_product}" class="dropdown-content">
                                <li>
                                    <a href="/product/edit/{$product.id}" title="Xem thông tin sản phẩm">
                                        <i class="material-icons left">edit</i>
                                        Xem thông tin
                                    </a>   
                                </li>                                           
                                <li class="divider"></li>
                                <li>
                                    <a class="delete-product" title="Xóa sản phẩm">
                                        <i class="material-icons left">delete_forever</i>
                                        Xóa
                                    </a>                                            
                                </li>
                            </ul>
                        </td>                                
                    </tr>    
                    {if !empty($product.items) && sizeof($product.items > 1)}
                        {foreach from = $product.items key = k_item item = item}
                            {if $k_item > 0}
                                <tr class="{$tr_class}">
                                    <td>
                                    </td>

                                    <td class="center">
                                        {if !empty($item.code)}
                                            {$item.code}
                                        {/if}
                                    </td>

                                    <td class="center">
                                        {if !empty((float)$item.price)}
                                            {$item.price|number_format:0:",":","}
                                        {/if}
                                    </td>

                                    <td class="center">
                                        {if !empty((float)$item.price_discount)}
                                            {$item.price_discount|number_format:0:",":","}
                                        {/if}
                                    </td>

                                    <td>
                                    </td>

                                    <td class="center">
                                        {if !empty($item.status)}
                                            <i class="material-icons f-s-14 text-green">check</i>
                                        {else}
                                            <i class="material-icons f-s-14">no_encryption</i>
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/if} 
                {/foreach}
            {else}
                <tr >
                    <td colspan="12" class="center">
                        <i class="">
                            Không tìm thấy sản phẩm nào
                        </i>
                    </td>                            
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<div class="card-action p-v-xxs">
    <div class="row no-m valign-wrapper">
        <div class="col s12 m2 l1 no-p hide-on-small-only">
            {$this->Form->select('limit', $limit_pagination, [id => 'limit', name => '', empty => null, default => {"{if !empty($pagination.limit)}{$pagination.limit}{else}PAGE_DEFAULT{/if}"}])}
            <input type="hidden" name="limit" value="{if !empty($pagination.limit)}{$pagination.limit}{/if}" />
        </div>
        <div class="col s12 m10 l11 right-align no-p">
            {$this->element('/layout/pagination',['pagination'=> $pagination])}
        </div>        
    </div>
</div>
<input type="hidden" name="limit" value="{if !empty($pagination.limit)}{$pagination.limit}{/if}" />
<input type="hidden" name="sort" value="{if !empty($params.sort)}{$params.sort}{/if}" />
<input type="hidden" name="direction" value="{if !empty($params.direction)}{$params.direction}{/if}" />
<input type="hidden" name="page" value="{if !empty($pagination.page)}{$pagination.page}{/if}" />