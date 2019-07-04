{if !empty($lazada_attributes)}
    {foreach from = $lazada_attributes item = attribute}
        {assign var = attribute_value value = ''}
        {if !empty($item.lazada_item_attributes[$attribute.code])}
            {assign var = attribute_value value = $item.lazada_item_attributes[$attribute.code]}
        {/if}

        {if $attribute.code == 'brand'}
            <div class="input-field col s12 m12 l6">
                <input id="lazada_{$attribute.code}" name="lazada_normal[{$attribute.code}]" type="text" class="w-100 autocomplete" autocomplete="off" value="{if !empty($attribute_value)}{$attribute_value}{/if}">
                <label for="lazada_{$attribute.code}">{$attribute.name}</label>
            </div>
        {else}
            <div class="input-field col s12 m4 l3">                
                {$this->element('/lazada/input',['attribute' => $attribute, 'attribute_value' => $attribute_value , 'show_icon' => "{if !empty($show_icon)}1{/if}" , 'index' => "{if isset($index)}{$index}{/if}"])}
            </div>
        {/if}        
    {/foreach}
{/if}