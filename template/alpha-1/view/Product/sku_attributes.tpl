{if !empty($lazada_sku_attributes)}
    {foreach from = $lazada_sku_attributes item = attribute} 
        {if !empty($attribute.is_mandatory)}                      
            <div class="input-field col s12 m4 l3">
                {assign var = attribute_value value = ''}
                {if !empty($item.lazada_item_attributes[$attribute.code])}
                    {assign var = attribute_value value = $item.lazada_item_attributes[$attribute.code]}
                {/if}
                {$this->element('/lazada/input',['attribute' => $attribute, 'attribute_value' => $attribute_value , 'show_icon' => true])}
            </div>
        {/if}
    {/foreach}
{/if}