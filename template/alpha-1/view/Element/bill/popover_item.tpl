<div id="popover-item" style="display: none;">
    <div class="row popover-xs">

        <div class="input-field col s12 m12 l12">
            <input id="popover-item-price" type="text" autocomplete="off" value="" class="auto-numeric right-align">
            <label class="alway-active">
                Đơn giá 
            </label>
        </div>

        <div class="input-field col s12 m12 l12">
            {$this->Form->select('type_discount', $type_discount , ['id'=>'popover-item-type-discount', 'empty' => null, 'default' => '' , 'class' => ''])}
            <label>
                Loại chiết khấu
            </label>
        </div>

        <div class="input-field col s12 m12 l12">
            <input id="popover-item-discount" type="text" autocomplete="off" value="" class="auto-numeric right-align">
            <label class="alway-active">
                Chiết khấu thường
            </label>
        </div>

        <div class="input-field col s12 m12 l12">
            <input id="popover-item-vat" type="text" autocomplete="off" value="" class="auto-numeric right-align">
            <label class="alway-active">
                Thuế (%)
            </label>
        </div>
    </div>
</div>