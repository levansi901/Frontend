{assign var=data_breadcrumb value=[
0=>['title'=> 'Danh sách', 'url' => '/product'],
1=>['title'=> "{$title_view}", 'url' => ""]
]}

{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
	<div class="card">
        <div class="card-content my-form">
            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="name" name="name" type="text" length="255" maxlength="255" autocomplete="off" value="{if !empty($product.name)}{$product.name}{/if}">
                    <label for="name">Tên sản phẩm</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="select_lazada_category" name="select_lazada_category" type="text" autocomplete="off">
                    <label for="select_lazada_category">
                        Danh mục Lazada
                        <div class="lazada-icon" tooltip="Thuộc tính Lazada"><div>LAZ</div></div>
                    </label>

                    <input type="hidden" id="lazada_category_id" name="lazada_category_id" value="{if !empty($product.lazada_category_id)}{$product.lazada_category_id}{/if}">

                    <input type="hidden" id="lazada_category_tree_ids" name="lazada_category_tree_ids" value="{if !empty($product.lazada_category_tree_ids)}{$product.lazada_category_tree_ids|@json_encode}{/if}">
                    
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="lazada_brand_id" name="lazada_brand_id" class="autocomplete" type="text" autocomplete="off">
                    <label for="lazada_brand_id">
                        Thương hiệu Lazada
                        <div class="lazada-icon" tooltip="Thuộc tính Lazada"><div>LAZ</div></div>
                    </label>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Phiên bản sản phẩm</span>
            <div class="row">
                <ul class="collapsible popout" data-collapsible="expandable">
                    {if !empty($product.items)}
                        {foreach from = $product.items key=k item = item}
                            {assign var = number value = $k + 1}
                            <li class="{if $k == 0}active{/if}">
                                <div class="collapsible-header">
                                    <i class="material-icons m-r-xs">
                                        filter_{if $number < 10}{$number}{else}9_plus{/if}
                                    </i>
                                    <span class="title-item m-r-xxl"> 
                                        {if !empty($item.code)}{$item.code}{/if} 
                                    </span>
                                    <div class="chip">HTML</div>
                                    <div class="chip">HTML</div>
                                    <div class="chip">HTML</div>
                                    <i class="material-icons no-m right" title="Xóa">delete_forever</i>
                                </div>
                                <div class="collapsible-body" style="{if $k == 0}display: block;{/if}">
                                    <div class="row">
                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-code-{$k}" data-name="item-code" name="item[code][]" type="text" class="w-100" length="100" maxlength="100" autocomplete="off" value="{if !empty($item.code)}{$item.code}{/if}" >
                                            <label for="item-code-{$k}"> 
                                                Mã 
                                            </label>
                                        </div>

                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-barcode-{$k}" data-name="item-barcode" name="item[barcode][]" type="text" class="w-100" autocomplete="off" length="20" maxlength="20" value="{if !empty($item.barcode)}{$item.barcode}{/if}" >
                                            <label for="item-barcode-{$k}"> 
                                                Mã vạch 
                                            </label>
                                        </div>                                
                                    </div>

                                    <div class="row">
                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-price-{$k}" data-name="item-price" name="item[price][]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price)}{$item.price}{/if}">
                                            <label for="item-price-{$k}"> 
                                                Giá bán 
                                            </label>
                                        </div>

                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-price-discount-{$k}" data-name="item-price-discount" name="item[price_discount][]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_discount)}{$item.price_discount}{/if}">
                                            <label for="item-price-discount-{$k}"> 
                                                Giá khuyến mãi 
                                            </label>                                    
                                        </div>

                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-time-start-{$k}" data-name="item-time-start" name="item[time_start_discount][]" type="text" class="w-100" autocomplete="off" value="{if !empty($item.time_start_discount)}{$item.time_start_discount}{/if}">
                                            <label for="item-time-start-{$k}"> 
                                                Ngày bắt đầu giảm giá 
                                            </label>                                    
                                        </div>

                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-time-end-{$k}" data-name="item-time-end" name="item[time_end_discount][]" type="text" class="w-100" autocomplete="off" value="{if !empty($item.time_end_discount)}{$item.time_end_discount}{/if}">
                                            <label for="item-time-end-{$k}">
                                                Ngày kết thúc giảm giá
                                            </label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-price-import-{$k}" data-name="item-price-import" name="item[price_import][]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_import)}{$item.price_import}{/if}">
                                            <label for="item-price-import-{$k}">
                                                Giá nhập
                                            </label>
                                        </div>

                                        <div class="input-field col s12 m4 l3">
                                            <input id="item-price-whole-sale-{$k}" data-name="item-price-whole-sale" name="item[price_whole_sale][]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_whole_sale)}{$item.price_whole_sale}{/if}">
                                            <label for="item-price-whole-sale-{$k}">
                                                Giá buôn
                                            </label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="file-field input-field col s12 m4 l6">
                                            <div class="btn">
                                                <i class="material-icons">perm_media</i>
                                                <input type="file" multiple>
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Chọn 1 hoặc nhiều ảnh">
                                            </div>
                                        </div>

                                        <div class="col s12 m6 l6">
                                            <div class="col s2 m3 l2">
                                                <img style="height: 40px;" class="" src="/template/alpha-1/assets/images/card-image.jpg" alt="">
                                            </div>                                
                                        </div>                                
                                    </div>
                                </div>
                            </li>
                        {/foreach}
                    {/if}
                </ul>
            </div>
            <div class="row">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th class="center w-2">
                                Hiển thị
                            </th>

                            <th class="w-8">
                                Mã sản phẩm
                            </th>

                            <th class="center w-8">
                                Giá sản phẩm
                            </th>
                            <th class="center w-8">
                                Giá đặc biệt
                            </th>
                            <th class="center w-5">
                                Số lượng
                            </th>
                            
                            <th class="center w-10">
                                <i class="material-icons f-s-16">perm_media</i>
                            </th>
                            <th class="center w-2">
                                <i class="material-icons f-s-16">cloud_upload</i>
                            </th>
                            <th class="center w-2">
                                <i class="material-icons f-s-16">delete</i>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {if !empty($product.items_bk)}
                            {foreach from = $product.items item = item}
                                <tr>
                                    <td class="center">
                                        <div class="switch">
                                            <label>
                                                <input type="checkbox">
                                                <span class="lever no-m"></span>
                                            </label>
                                        </div>
                                    </td>

                                    <td>
                                        <input name="item[code][]" type="text" class="w-100" autocomplete="off" value="{if !empty($item.code)}{$item.code}{/if}">
                                    </td>

                                    <td>
                                        <div class="my-input">
                                            <input name="item[price][]" type="text" class="w-100" autocomplete="off" value="{if !empty($item.price)}{$item.price}{/if}">
                                        </div>
                                    </td>

                                    <td class="center">
                                        <div class="my-input">
                                            <input name="item[price_special][]" type="text" class="w-100" autocomplete="off" value="{if !empty($item.price_discount)}{$item.price_discount}{/if}">
                                        </div>
                                    </td>

                                    <td class="center">
                                        <div class="my-input">
                                            <input name="item[price_special][]" type="text" class="w-100" autocomplete="off">
                                        </div>
                                    </td>

                                    <td class="center">
                                        
                                    </td>

                                    <td class="center">
                                        <a class="btn-floating btn-mini waves-effect waves-light green">
                                            <i class="material-icons">cloud_upload</i>
                                        </a>
                                    </td>                            

                                    <td class="center">
                                        <a class="btn-floating btn-mini waves-effect waves-light red">
                                            <i class="material-icons">delete</i>
                                        </a>                                
                                    </td>
                                </tr>
                            {/foreach} 
                        {/if}               
                    </tbody>
                    <tfoot>
                        <tr>
                            <td class="center cursor-pointer" colspan="20">
                                <i class="icon-plus2"></i> Thêm phiển bản mới </td>
                            </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Thuộc tính Lazada</span>
            <div class="row">
  
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Thông tin khác</span>
            <div class="row">
                <div class="input-field col s12 m4 l3">
                    {$this->Form->select('status',$list_status , ['name'=>'status','empty' => "Trạng thái",'default' => {"{if !empty($product.status)}{$product.status}{/if}"} ,'class' => ''])}
                    <label>Trạng thái</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12 m4 l3">
                    <input id="width" name="width" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.width)}{$product.width}{/if}">
                    <label for="width">Chiều rộng <small>(cm)</small></label>
                </div>

                <div class="input-field col s12 m4 l3">
                    <input id="length" name="length" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.length)}{$product.length}{/if}">
                    <label for="length">Chiều dài <small>(cm)</small></label>
                </div>

                <div class="input-field col s12 m4 l3">
                    <input id="height" name="height" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.height)}{$product.height}{/if}">
                    <label for="height">Chiều cao <small>(cm)</small></label>
                </div>

                <div class="input-field col s12 m4 l3">
                    <input id="weight" name="weight" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.weight)}{$product.weight}{/if}">
                    <label for="weight">Cân nặng <small>(gram)</small></label>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Mô tả sản phẩm</span>
            <div class="row">
  
            </div>
        </div>
    </div>

    <div class="mn-header navbar-fixed">
        <nav class="white nav-action">
            <div class="row center">
                <span class="p-v-xs hide-on-small-only">
                    <input id="redirect-list" name="after_save" type="radio" checked="true" />
                    <label for="redirect-list">Về trang danh sách</label>
                </span>
                <span class="p-v-xs hide-on-small-only">
                    <input id="redirect-form" name="after_save" type="radio"  />
                    <label for="redirect-form">Về trang thêm mới</label>
                </span>                    

                <span class="waves-effect waves-light btn black m-l-lg m-r-xs s6">
                    <i class="material-icons left lh-36">close</i>
                    Hủy bỏ
                </span>

                <span class="waves-effect waves-light btn s6">
                    <i class="material-icons left lh-36">check</i>
                    Thêm mới
                </span>
            </div>    
        </nav>
    </div>

    <div class="hide">
        <input type="hidden" id="csrf_token" value="{if !empty($csrf_token)}{$csrf_token}{/if}">
    </div>
</div>

<div id="modal-lazada-category" class="modal modal-lazada-category">
    <div class="modal-content">
        <h4>Chọn danh mục</h4>
        <div class="row group-level">        
        </div>  

        <div class="row m-b-xs right">
            <a class="modal-close waves-effect waves-light btn black m-r-xs s6">Hủy bỏ</a>
            <a id="btn-selected" class="waves-effect waves-light btn s6 disabled">
                Đồng ý
            </a>
        </div>      
    </div>    
</div>
