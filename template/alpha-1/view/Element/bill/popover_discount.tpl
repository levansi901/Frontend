<div id="popover-discount" style="display: none;">
    <div class="row popover-xs">
    	<div class="input-field col s12 m12 l12">
            {$this->Form->select('popover-bill-type-discount', $type_discount , ['id'=>'popover-bill-type-discount', 'empty' => null, 'default' => '' , 'class' => ''])}
            <label>
                Loại chiết khấu
            </label>
        </div>
        <div class="input-field col s12 m12 l12">
            <input id="popover-bill-discount" type="text" autocomplete="off" value="" class="auto-numeric right-align">
            <label class="alway-active">
                Chiết khấu thường
            </label>
        </div>
    </div>
</div>
