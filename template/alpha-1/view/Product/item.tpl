{assign var = k value = $number - 1}
<li data-index="{$k}" data-item-id="{if !empty($item.id)}{$item.id}{/if}" class="li-item">
    <div class="collapsible-header">
        <i class="material-icons m-r-xs index-item">
            filter_{if $number < 10}{$number}{else}9_plus{/if}
        </i>
        <span class="title-item m-r-xxl"> 
            {if !empty($item.code)}{$item.code}{/if} 
        </span>        
        <i class="material-icons no-m right delete-item" title="Xóa">delete_forever</i>
    </div>
    
    <div class="collapsible-body">        
        <div class="row m-t-xs lazada-sku-attributes">
            {if !empty($lazada_sku_attributes)}
                {$this->element('../Product/lazada_attributes',['lazada_attributes' => $lazada_sku_attributes, 'show_icon' => true, 'index' => $k])}
            {/if}
        </div>
        
        <div class="row">
            <div class="input-field col s12 m4 l3">
                <input id="item-code-{$k}" data-name="item-code" name="items[{$k}][code]" type="text" class="w-100" length="100" maxlength="100" autocomplete="off" value="{if !empty($item.code)}{$item.code}{/if}" >
                <label for="item-code-{$k}"> 
                    Mã
                    <small class="label-required text-red">*</small>
                </label>
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-barcode-{$k}" data-name="item-barcode" name="items[{$k}][barcode]" type="text" class="w-100" autocomplete="off" length="20" maxlength="20" value="{if !empty($item.barcode)}{$item.barcode}{/if}" >
                <label for="item-barcode-{$k}"> 
                    Mã vạch 
                </label>
            </div>                                
        </div>

        <div class="row">
            <div class="input-field col s12 m4 l3">
                <input id="item-price-{$k}" data-name="item-price" name="items[{$k}][price]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price)}{$item.price}{/if}">
                <label for="item-price-{$k}"> 
                    Giá bán
                    <small class="label-required text-red">*</small>
                </label>
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-price_discount-{$k}" data-name="item-price_discount" name="items[{$k}][price_discount]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_discount)}{$item.price_discount}{/if}">
                <label for="item-price_discount-{$k}"> 
                    Giá khuyến mãi 
                </label>                                    
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-time_start_discount-{$k}" data-name="item-time_start_discount" name="items[{$k}][time_start_discount]" type="text" class="w-100 input-date-picker" autocomplete="off" value="{if !empty($item.time_start_discount)}{date('d/m/Y - H:i', strtotime($item.time_start_discount))}{/if}">
                <label for="item-time_start_discount-{$k}"> 
                    Ngày bắt đầu giảm giá 
                </label>
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-time_end_discount-{$k}" data-name="item-time_end_discount" name="items[{$k}][time_end_discount]" type="text" class="w-100 input-date-picker" autocomplete="off" value="{if !empty($item.time_end_discount)}{date('d/m/Y - H:i', strtotime($item.time_end_discount))}{/if}">
                <label for="item-time_end_discount-{$k}">
                    Ngày kết thúc giảm giá
                </label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m4 l3">
                <input id="item-price-import-{$k}" data-name="item-price_import" name="items[{$k}][price_import]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_import)}{$item.price_import}{/if}">
                <label for="item-price-import-{$k}">
                    Giá nhập
                </label>
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-price_whole_sale-{$k}" data-name="item-price_whole_sale" name="items[{$k}][price_whole_sale]" type="text" class="w-100 auto-numeric" autocomplete="off" value="{if !empty($item.price_whole_sale)}{$item.price_whole_sale}{/if}">
                <label for="item-price_whole_sale-{$k}">
                    Giá buôn
                </label>
            </div>
        </div>

        <div class="row">
            <div class="file-field input-field col s12 m4 l6">
                <div class="waves-effect waves-light btn btn-select-image" data-src="{$cdn_url}/filemanager/dialog.php?type=1&crossdomain=1&akey={$filemanager_access_key}&field_id=item-images" data-type="iframe">
                    <i class="material-icons left lh-36">perm_media</i> 
                    Chọn ảnh
                </div>
                
                <div class="file-path-wrapper">
                    <input id="item-images-{$k}" data-name="item-images" name="items[{$k}][images]" type="text" placeholder="Chọn ảnh cho phiên bản sản phẩm" readonly="true" class="input-select-image">
                </div>
            </div>      

            <div class="preview-item-images col s12 m6 l6">
                {if !empty($item.images)}
                    {foreach from = $item.images key = k_image item = image}
                        <div class="item-image hoverable">
                            <a href="{$image}" data-fancybox="images">
                                <img class="h-60" src="{$this->Utilities->getThumb($image)}">                                
                            </a>

                            <div class="icons-inner valign-wrapper">
                                <a href="{$image}" data-fancybox="images" class="m-r-xxs"> 
                                    <i class="material-icons white-text f-s-18">open_in_new</i>
                                </a> 
                                <a href="#" class="delete-item-image"> 
                                    <i class="material-icons white-text f-s-18">delete_forever</i>
                                </a>
                            </div>
                        </div>                        
                    {/foreach}
                {/if}
            </div>                                
        </div>

        <div class="hide">
        	<input id="item-id-{$k}" data-name="item-id" name="items[{$k}][id]" type="hidden" value="{if !empty($item.id)}{$item.id}{/if}">
        </div>
    </div>
</li>