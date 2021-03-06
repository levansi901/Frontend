<div class="row no-m">
    <div class="input-field col s12 m6 l6">
        <input id="name_supplier" type="text" autocomplete="off" value="">
        <label for="name_supplier">
            Tên nhà cung cấp
            <small class="label-required text-red">*</small>
        </label>
    </div>

    <div class="input-field col s12 m6 l6">
        {$this->Form->select('group_supplier', $groups , ['id' => 'group_supplier','empty' => '-- Chọn --', 'default' => '' , 'class' => ''])}
        <label for="group_supplier" class="alway-active">
            Nhóm nhà cung cấp
        </label>
    </div>
</div>

<div class="row no-m">
    <div class="input-field col s12 m6 l6">
        <input id="phone_supplier" type="text" autocomplete="off" value="" class="phone-input">
        <label for="phone_supplier">
            Số điện thoại
        </label>
    </div>

    <div class="input-field col s12 m6 l6">
        <input id="email_supplier" type="text" autocomplete="off" value="">
        <label for="email_supplier">
            Email
        </label>
    </div>    
</div>

<div class="row no-m">    
    <div class="input-field col s12 m6 l6">
        <select id="city_distrct_supplier" class="select2 city-district" style="width: 100%;">
            <option value="">Tỉnh/Thành phố - Quận/Huyện</option>
            {if !empty($cities_districts)}
                {foreach from = $cities_districts key=key item=city_district}
                    <option value="{$city_district.city_id}-{$city_district.district_id}" data-city-id="{$city_district.city_id}" data-city-name="{$city_district.city_name}" data-district-id="{$city_district.district_id}" data-district-name="{$city_district.district_name}">{$city_district.city_name} - {$city_district.district_name}</option>
                {/foreach}
            {/if}
        </select>
        <label for="city_distrct_supplier" class="alway-active">
            Khu vực
        </label>

        <input id="city_id_supplier" type="hidden" value="" class="city" />
        <input id="city_name_supplier" type="hidden" value="" class="city-name" />
        <input id="district_id_supplier" type="hidden" value="" class="district" />        
        <input id="district_name_supplier" type="hidden" value="" class="district-name" />
    </div>

    <div class="input-field col s12 m6 l6">
        <input id="address_supplier" type="text" autocomplete="off" value="">
        <label for="address_supplier">
            Địa chỉ
            <small class="label-required text-red">*</small>
        </label>
    </div>
</div>
