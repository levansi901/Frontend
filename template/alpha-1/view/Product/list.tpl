<div class="card-content p-t-10 p-b-0 p-h-xs">   
    <table id="data-table" class="display responsive-table custom-table">
        <thead>
            <tr>
                <th class="w-3">
                    <input id="select-all" type="checkbox" class="filled-in no-text"/>
                    <label for="select-all"></label>
                    <div id="wrap-action-list" class="hide">
                            <a data-activates="action-list" class="dropdown-button waves-effect waves-light btn btn-action" title="Chọn hành động">
                            <i class="material-icons left">expand_more</i>
                            Chọn hành động
                        </a>  
                        <ul id="action-list" class="dropdown-content">
                            <li class="hide">
                                <a title="Giảm giá đồng loạt">
                                    <i class="material-icons left">card_giftcard</i>
                                    Giảm giá đồng loạt
                                </a>
                            </li>

                            <li>
                                <a class="change-status-selected" data-status="1" title="Kích hoạt sản phẩm">
                                    <i class="material-icons f-s-14 text-green">check</i>
                                    Hoạt động
                                </a>   
                            </li>

                            <li>
                                <a class="change-status-selected" data-status="0" title="Tạm ngừng hoạt động sản phẩm">
                                    <i class="material-icons f-s-14">no_encryption</i>
                                    Không hoạt động
                                </a>   
                            </li>

                            <li class="divider"></li>
                            <li>
                                <a class="delete-selected" title="Xóa sản phẩm">
                                    <i class="material-icons left text-red">delete_forever</i>
                                    Xóa
                                </a>                                            
                            </li>
                        </ul>
                    </div>
                </th>                
                <th class="w-30 left-align {if !empty($params.sort) && !empty($params.direction) && $params.sort == name}sorting_{$params.direction}{else}sorting{/if}" data-sort="name" title="Tên sản phẩm">
                    Sản phẩm
                </th>

                <th class="w-3">                    
                    
                </th>

                <th class="w-15 left-align" title="Mã sản phẩm"> 
                    Mã
                </th>

                <th class="w-15 left-align {if !empty($params.sort) && !empty($params.direction) && $params.sort == price}sorting_{$params.direction}{else}sorting{/if}" data-sort="price" title="Giá sản phẩm"> 
                    Giá
                </th>

                <th class="w-15 left-align {if !empty($params.sort) && !empty($params.direction) && $params.sort == price_discount}sorting_{$params.direction}{else}sorting{/if}" data-sort="price_discount" title="Giá khuyến mãi"> 
                    Giá KM
                </th>
                <th class="w-3 sorting" data-sort="inventory" title="Số lượng sản phẩm còn trong ko">Tồn</th>
                <th class="w-3" title="Trạng thái sản phẩm">TT</th>
            </tr>
        </thead>

        <tbody>                    
            {if !empty($products)}
                {assign var = product_id value= ''}
                {foreach from = $products key = k_product item = product}
                    {assign var = same_item value = false}
                    {if $product_id == $product.product_id}
                        {assign var = same_item value= true}                    
                    {/if}
                    <tr class="{if $same_item}same-item{/if}" data-id="{$product.id}" data-product-id="{$product.product_id}">
                        <td class="{if $same_item}same-column{/if} center">
                            <input id="row-{$k_product}" type="checkbox" class="filled-in no-text select-record"/>
                            <label for="row-{$k_product}"></label>                              
                        </td>                        

                        <td class="{if $same_item}same-column{/if}">
                            {if !empty($product.name) && !$same_item}
                                {$product.name}
                            {/if}
                        </td>

                        <td class="center p-l-0">
                            <a class="img" href="/product/edit/{$product.id}">
                                {if !empty($product.images[0])}
                                    <img class="img-product" src="{$product.images[0]}"/>
                                {else}
                                    <img src="/no-image.png"/>
                                {/if}
                                                             
                            </a>                            
                        </td>

                        <td >
                            {if !empty($product.code)}
                                <a href="/product/edit/{$product.id}" title="Xem thông tin sản phẩm">
                                    {$product.code}
                                </a>                                  
                            {/if}
                        </td>

                        <td>
                            {if !empty((float)$product.price)}
                                {$product.price|number_format:0:",":","}
                            {/if}
                        </td>

                        <td>
                            {if !empty((float)$product.price_discount)}
                                {$product.price_discount|number_format:0:",":","}
                            {/if}
                        </td>

                        <td class="center">
                            {if !empty($product.inventory)}
                                {$product.inventory|number_format:0:",":","}
                            {/if}
                        </td>

                        <td class="center status-column">
                            {if !empty($product.status)}
                                <i class="material-icons f-s-18 text-green" title="Sản phẩm đang được kích hoạt">check</i>
                            {else}
                                <i class="material-icons f-s-18" title="Sản phẩm đang không kích hoạt">no_encryption</i>
                            {/if}
                        </td>                              
                    </tr>
                    {assign var = product_id value= $product.product_id}
                {/foreach}
            {else}
                <tr>
                    <td colspan="12" class="center">
                        <i>
                            Không tìm thấy sản phẩm nào
                        </i>
                    </td>                            
                </tr>
            {/if}
        </tbody>
    </table>
</div>

{if !empty($pagination.pageCount) && $pagination.pageCount > 1}
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
{/if}

<input type="hidden" name="limit" value="{if !empty($pagination.limit)}{$pagination.limit}{/if}" />
<input type="hidden" name="sort" value="{if !empty($params.sort)}{$params.sort}{/if}" />
<input type="hidden" name="direction" value="{if !empty($params.direction)}{$params.direction}{/if}" />
<input type="hidden" name="page" value="{if !empty($pagination.page)}{$pagination.page}{/if}" />