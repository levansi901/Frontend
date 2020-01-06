<div class="card-content p-t-10 p-b-0 p-h-xs">
    <div class="table-responsive">
        <table id="data-table" class="display custom-table">
            <thead>
                <tr>
                    <th class="w-1 left-align">
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

                    <th class="w-10 left-align" title="Mã phiếu">
                        Mã phiếu
                    </th>                    

                    <th class="w-10 left-align" title="Loại phiếu"> 
                        Loại phiếu
                    </th>

                    <th class="w-10 left-align" title="Kho hàng"> 
                        Kho hàng
                    </th>

                    <th class="w-3" title="Số lượng">
                        SL
                    </th>

                    <th class="w-10 right-align" title="Tổng tiền">
                        Tổng tiền
                    </th>                    

                    <th class="w-5" title="Người tạo"> 
                        Người tạo
                    </th>
                </tr>
            </thead>

            <tbody>                
                {if !empty($bills)}
                    {foreach from = $bills key = k_bill item = item}

                        <tr data-id="{if !empty($item.bill.id)}{$item.bill.id}{/if}">
                            <td>
                                <input id="row-{$k_bill}" type="checkbox" class="filled-in no-text select-record"/>
                                <label for="row-{$k_bill}"></label>                              
                            </td>                         

                            <td>
                                {if !empty($item.bill.code)}
                                    <a href="#" title="Xem thông tin phiếu">
                                        {$item.bill.code}
                                    </a>                                  
                                {/if}
                            </td>

                            <td>
                                {if $item.bill.type == 'IMPORT'}
                                    <span class="text-green">Nhập</span>
                                {/if}

                                {if $item.bill.type == 'EXPORT'}
                                    <span class="text-red">Xuất</span>
                                {/if}

                                {if !empty($list_type_receipt[$item.bill.type_receipt])}
                                    - {$list_type_receipt[$item.bill.type_receipt]}
                                {/if}                            
                            </td>

                            <td>
                                {if !empty($item.bill.shop_name)}
                                    {$item.bill.shop_name}
                                {/if}
                            </td>

                            <td class="center">
                                {if !empty($item.bill.total_items)}
                                    {$item.bill.total_items|number_format:0:".":","}
                                {/if}
                            </td>

                            <td class="right-align">
                                {if !empty($item.bill.total_final)}
                                    {$item.bill.total_final|number_format:0:".":","}
                                {/if}
                            </td>

                            <td class="center">
                                {if !empty($item.bill.created_by_name)}
                                    {$item.bill.created_by_name}
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