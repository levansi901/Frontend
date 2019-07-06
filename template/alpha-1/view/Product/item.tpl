{assign var = k value = $number - 1}
<li data-index="{$k}" class="li-item">
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
                <label for="item-price-discount-{$k}"> 
                    Giá khuyến mãi 
                </label>                                    
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-time_start_discount-{$k}" data-name="item-time_start_discount" name="items[{$k}][time_start_discount]" type="text" class="w-100 input-date-picker" autocomplete="off" value="{if !empty($item.time_start_discount)}{$item.time_start_discount}{/if}">
                <label for="item-time-start-{$k}"> 
                    Ngày bắt đầu giảm giá 
                </label>
            </div>

            <div class="input-field col s12 m4 l3">
                <input id="item-time_end_discount-{$k}" data-name="item-time_end_discount" name="items[{$k}][time_end_discount]" type="text" class="w-100 input-date-picker" autocomplete="off" value="{if !empty($item.time_end_discount)}{$item.time_end_discount}{/if}">
                <label for="item-time-end-{$k}">
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
                <label for="item-price-whole-sale-{$k}">
                    Giá buôn
                </label>
            </div>
        </div>

        <div class="row">
            <div class="file-field input-field col s12 m4 l6">
                <div class="btn">
                    <i class="material-icons">perm_media</i>
                    <input id="item-upload_images-{$k}" data-name="item-upload_images" name="items[{$k}][upload_images]" type="file" multiple>
                </div>
                <div class="file-path-wrapper">
                    <input class="file-path" type="text" placeholder="Chọn 1 hoặc nhiều ảnh">
                </div>
            </div>

            <div class="col s12 m6 l6">
                <div class="col s2 m3 l2">
                    <!-- <img style="height: 40px;" class="" src="/template/alpha-1/assets/images/card-image.jpg" alt=""> -->
                </div>                                
            </div>                                
        </div>

        <div class="hide">
        	<input id="item-id-{$k}" data-name="item-id" name="items[{$k}][id]" type="hidden" value="{if !empty($item.id)}{$item.id}{/if}">
        </div>
    </div>
</li>