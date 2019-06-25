{if !empty($attribute) && $attribute.input_type|in_array:['singleSelect','multiEnumInput']}
    {$this->Form->select("lazada_{$attribute.code}",$attribute.options , ['name'=> "lazada_normal[{$attribute.code}]",'empty' => "{$attribute.name}",'default' => {"{if !empty($attribute_value)}{$attribute_value}{/if}"}])}
    <label for="lazada_{$attribute.code}">
    	{if !empty($show_icon)}
    		{$this->element('/lazada/icon')}
    	{/if}
        {$attribute.name}        
    </label>
{elseif !empty($attribute) && $attribute.input_type == 'text'}
    <input id="lazada_{$attribute.code}" name="lazada_normal[{$attribute.code}]" type="text" class="w-100" autocomplete="off" value="{if !empty($attribute_value)}{$attribute_value}{/if}" >
    <label for="lazada_{$attribute.code}">
    	{if !empty($show_icon)}
    		{$this->element('/lazada/icon')}
    	{/if}
        {$attribute.name}
    </label>
{/if}