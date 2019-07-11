<div class="card-content p-t-10 p-b-0 p-h-xs">
    <table id="data-table" class="display responsive-table custom-table">
        <thead>
            <tr>
                <th class="w-3">
                    <input id="select-all" type="checkbox" class="filled-in no-text"/>
                    <label for="select-all"></label>
                </th>
                <th class="w-3 {if !empty($params.sort) && !empty($params.direction) && $params.sort == id}sorting_{$params.direction}{else}sorting{/if}" data-sort="id">
                    ID
                </th>
                <th class="w-3">
                    <i class="material-icons f-s-22">photo_library</i>
                </th>
                <th class="w-30 left-align {if !empty($params.sort) && !empty($params.direction) && $params.sort == name}sorting_{$params.direction}{else}sorting{/if}" data-sort="name">
                    Tên sản phẩm
                </th>

                <th class="w-15 left-align"> 
                    Mã
                </th>

                <th class="w-15 {if !empty($params.sort) && !empty($params.direction) && $params.sort == price}sorting_{$params.direction}{else}sorting{/if}" data-sort="price"> 
                    Giá
                </th>

                <th class="{if !empty($params.sort) && !empty($params.direction) && $params.sort == price_discount}sorting_{$params.direction}{else}sorting{/if}" data-sort="price_discount" title="Giá khuyến mãi"> 
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
                    <tr data-id="{$product.id}" >
                        <td class="center">
                            <input id="row-{$k_product}" type="checkbox" class="filled-in no-text select-record"/>
                            <label for="row-{$k_product}"></label>                              
                        </td>

                        <td>
                            {if !empty($product.id)}
                                {$product.id}
                            {/if}
                        </td>

                        <td class="center">
                            <a class="btn btn-xxs blue-grey darken-4 btn-small">
                                <i class="material-icons f-s-22">photo_camera</i>
                            </a>                                    
                        </td>

                        <td>
                            {if !empty($product.name)}
                                {$product.name}
                            {/if}
                        </td>


                        <td >
                            {if !empty($product.code)}
                                {$product.code}
                            {/if}
                        </td>

                        <td class="center">
                            {if !empty((float)$product.price)}
                                {$product.price|number_format:0:",":","}
                            {/if}
                        </td>

                        <td class="center">
                            {if !empty((float)$product.price_discount)}
                                {$product.price_discount|number_format:0:",":","}
                            {/if}
                        </td>

                        <td class="center">
                            
                        </td>

                        <td class="center">
                            {if !empty($product.status)}
                                <i class="material-icons f-s-14 text-green">check</i>
                            {else}
                                <i class="material-icons f-s-14">no_encryption</i>
                            {/if}
                        </td>

                        <td class="center">
                            <a class="dropdown-button btn btn-xxs btn-small" data-activates="setting-{$k_product}">
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
                                        <i class="material-icons left text-red">delete_forever</i>
                                        Xóa
                                    </a>                                            
                                </li>
                            </ul>
                        </td>                                
                    </tr>
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