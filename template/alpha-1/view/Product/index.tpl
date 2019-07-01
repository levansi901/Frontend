{assign var=data_breadcrumb value=[0=>['title'=> 'Danh sách sản phẩm','url' => ""]]}
{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
	<div class="card">
        <div class="card-content">
        	<div class="row">
                <div class="input-field col s12 m4 l3">
                    <input id="keyword" name="keyword" type="text" maxlength="100" autocomplete="off">
                    <label for="keyword">Tên / Mã sản phẩm</label>
                </div>

                <div class="input-field col s12 m4 l2">   
                	{$this->Form->select('status',$list_status , ['name'=>'status','empty' => "Trạng thái",'default' => '' ,'class' => ''])}
                    <label>Trạng thái</label>
                </div>

                

                <div class="input-field col s12 m12 l3">
                	<a class="waves-effect waves-light btn blue m-b-xs">
                		Tìm kiếm
	                </a>

	                <a class="btn-floating br-2 btn waves-effect waves-light green m-b-xs">
                		<i class="material-icons">loop</i>
	                </a>

	                <a class="btn-floating br-2 btn waves-effect waves-light blue-grey darken-4 m-b-xs">
                		<i class="material-icons">keyboard_arrow_right</i>
	                </a>
                </div>                
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content">      
        	<div class="s12">
        		<a href="/product/add" class="waves-effect waves-light btn green m-b-xs">
        			<i class="material-icons left">add</i>
            		Thêm sản phẩm mới
                </a>				
        	</div>      
            <table class="display responsive-table custom-table">
                <thead>
                    <tr>
                    	<th rowspan="2">
                    		<input id="check-all" type="checkbox" class="filled-in no-text"/>
                    		<label for="check-all"></label>
                    	</th>
                    	<th rowspan="2">
                            <i class="material-icons">image</i>
                    	</th>
                        <th rowspan="2">Tên sản phẩm</th>
                        <th colspan="4">Phiên bản sản phẩm</th>
                        <th rowspan="2">Tồn kho</th>
                        <th rowspan="2">TT</th>
                        <th rowspan="2"></th>
                    </tr>

                    <tr>
                    	<th> 
                    		Thuộc tính
                    	</th>

                    	<th> 
                    		Mã
                    	</th>

                    	<th> 
                    		Mã vạch
                    	</th>

                    	<th> 
                    		Giá
                    	</th>
					</tr>
                </thead>
                <tbody>                    
                    {if !empty($products)}
                        {foreach from = $products key = k_product item = product}
                            {assign var=url_edit value ="/product/edit-product/{$product.id}"}
                            {assign var=rowspan value ={sizeof($product.items)}}
                            {if empty(($k_product + 1) % 2)}
                                {assign var = tr_class value = 'even'}
                            {else}
                                {assign var = tr_class value = 'odd'}
                            {/if}
                            <tr class="{$tr_class}">
                            	<td class="center" rowspan="{$rowspan}">
                                    <input id="row-{$k_product}" type="checkbox" class="filled-in no-text"/>
                                    <label for="row-{$k_product}"></label>                         		
                            	</td>

                            	<td rowspan="{$rowspan}">
                                    <i class="material-icons lh-30">image</i>
                            	</td>

                                <td rowspan="{$rowspan}">
                                	{if !empty($product.name)}
                                        {$product.name}
                                    {/if}
                                </td>

                                <td>
        	                        
        	                    </td>

                                <td>
        	                        {if !empty($product.items.0.code)}
                                        {$product.items.0.code}
                                    {/if}
        	                    </td>

                                <td>
                                	{if !empty($product.items.0.barcode)}
                                        {$product.items.0.barcode}
                                    {/if}
                                </td>
                                <td>
        	                        {if !empty($product.items.0.price)}
                                        {$product.items.0.price}
                                    {/if}
        	                    </td>

                                <td>
                                	10
                                </td>

                                <td>
                                </td>

                                <td>
                                </td>                                
                            </tr>    
                            {if !empty($product.items) && sizeof($product.items > 1)}
                                {foreach from = $product.items key = k_item item = item}
                                    <tr class="{$tr_class}">
                                        <td>
                                        </td>
                                        
                                        <td>
                                            {if !empty($item.code)}
                                                {$item.code}
                                            {/if}
                                        </td>

                                        <td>
                                            {if !empty($item.barcode)}
                                                {$item.barcode}
                                            {/if}
                                        </td>
                                        <td>
                                            {if !empty($item.price)}
                                                {$item.price}
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if} 
                        {/foreach}
                    {/if}
                </tbody>
            </table>
        </div>
    </div>
</div>