{assign var=data_breadcrumb value=[0=>['title'=> {$title_for_layout},'url' => ""]]}
{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
    <form id="form-list-data" class="no-m no-p">    
    	<div class="card">
            <div class="card-content">
            	<div class="row">
                    <div class="input-field col s12 m4 l3">
                        <input id="keyword" name="keyword" type="text" maxlength="100" autocomplete="off">
                        <label for="keyword">Tên / Mã sản phẩm</label>
                    </div>

                    <div class="input-field col s12 m4 l2">   
                    	{$this->Form->select('status', $list_status , ['name'=>'status', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                        <label for="status">Trạng thái</label>
                    </div>

                    <div class="input-field col s12 m4 l2">   
                        {$this->Form->select('shop_id', $list_shops , ['name'=>'shop_id', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                        <label for="shop_id">Cửa hàng</label>
                    </div>

                    <div class="input-field col s12 m12 l3">
                    	<a class="waves-effect waves-light btn m-b-xs">
                    		Tìm kiếm
    	                </a>

    	                <a class="btn-floating br-2 btn waves-effect waves-light m-b-xs">
                    		<i class="material-icons">loop</i>
    	                </a>

    	                <a class="btn-floating br-2 btn waves-effect waves-light blue-grey darken-4 m-b-xs">
                    		<i class="material-icons">keyboard_arrow_down</i>
    	                </a>
                    </div>                
                </div>
            </div>
        </div>

        <div data-url="/product/list" id="wrap-list" class="card">
            {$this->element('../Product/list')}
        </div>
    </form>
</div>

<input type="hidden" id="csrf_token" value="{if !empty($csrf_token)}{$csrf_token}{/if}">