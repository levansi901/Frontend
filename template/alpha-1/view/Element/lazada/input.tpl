{assign var = attribute_name value = 'lazada_normal'}
{assign var = attribute_id value = {$attribute.code}}
{if $attribute.attribute_type == 'sku'}
    {assign var = attribute_name value = "items[{$index}][lazada_item_attributes][{$attribute.code}]"}
    {assign var = data_name value = "item-{$attribute.code}"}
    {assign var = attribute_id value = "{item-{$attribute.code}-{$index}}"}
{/if}

{if $attribute.input_type|in_array:['singleSelect','multiEnumInput']}
    {$this->Form->select($attribute_id, $attribute.options, ['name'=> $attribute_name, 'data-name' => "{if isset($data_name)}{$data_name}{/if}", 'data-lazada-type' => {$attribute.attribute_type}, 'empty' => "{$attribute.name}", 'default' => {"{if !empty($attribute_value)}{$attribute_value}{/if}"}])}
    <label for="{$attribute_id}">
    	{if !empty($show_icon)}
    		{$this->element('/lazada/icon')}
    	{/if}
        {$attribute.name}        
    </label>
{elseif $attribute.input_type == 'text'}
    <input id="{$attribute_id}" name="{$attribute_name}" data-name="{if isset($data_name)}{$data_name}{/if}" data-lazada-type="{$attribute.attribute_type}"  type="text" class="w-100" autocomplete="off" value="{if !empty($attribute_value)}{$attribute_value}{/if}" >
    <label for="{$attribute_id}">
    	{if !empty($show_icon)}
    		{$this->element('/lazada/icon')}
    	{/if}
        {$attribute.name}
    </label>
{/if}