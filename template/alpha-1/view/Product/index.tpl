<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
            Sản phẩm
        </span>        
    </div>
    <div class="col s6 m6 l6 no-p right-align">
        <a href="/product/add" class="waves-effect waves-light green btn" title="Thêm sản phẩm mới">
            <i class="material-icons left">add</i>
            Thêm sản phẩm mới
        </a>
    </div>    
</div>
  
<div class="row no-m">
    <form id="form-list-data" action="/product/list" class="no-m no-p">    
    	<div id="wrap-filter" class="card no-m">
            <div class="card-content p-v-xs p-h-xs m-b-xs p-b-0">
            	<div class="row no-m">
                    <div class="input-field col s12 m4 l6">
                        <input id="keyword" name="keyword" type="text" maxlength="100" autocomplete="off">
                        <label for="keyword">Tìm kiếm sản phẩm</label>
                    </div>     

                    <div class="input-field col s12 m4 l3">
                        {$this->Form->select('shop_id', $list_shops , ['name'=>'shop_id', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                        <label for="shop_id">Cửa hàng</label>
                    </div>               

                    <div class="input-field col s12 m4 l3 right-align">
                    	<a id="filter-data" class="waves-effect waves-light btn m-b-xs m-r-xxs" title="Tìm kiếm">
                    		Tìm kiếm
    	                </a>

    	                <a id="reset-filter" class="btn-floating btn waves-effect waves-light m-b-xs" title="Làm mới">
                    		<i class="material-icons">refresh</i>
    	                </a>

    	                <a id="more-filter" class="btn-floating btn waves-effect waves-light blue-grey darken-4 m-b-xs" title="Hiển thị bộ lọc khác">
                    		<i class="material-icons">keyboard_arrow_down</i>
    	                </a>
                    </div>
                </div>

                <div class="row no-m m-l-n-xs m-r-n-xs">
                     <ul id="wrap-more-filter" class="collapsible no-m">
                        <li>
                            <div class="collapsible-body">
                                <div class="row no-m p-v-xs">
                                    <div class="input-field col s12 m4 l3">   
                                        {$this->Form->select('status', $list_status , ['name'=>'status', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="status">Trạng thái</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">   
                                        {$this->Form->select('has_inventory', $list_has_inventory , ['name'=>'has_inventory', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="has_inventory">Tình trạng</label>
                                    </div>                                    

                                    <div class="input-field col s12 m4 l3">   
                                        {$this->Form->select('has_image', $list_has_image , ['name'=>'has_image', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="has_image">Hình ảnh</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">   
                                        {$this->Form->select('brand_id', $list_brands , ['name'=>'brand_id', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="brand_id">Thương hiệu</label>
                                    </div> 

                                    <div class="input-field col s12 m4 l3">
                                        <input id="price_from" name="price_from" type="text" maxlength="11" autocomplete="off" class="auto-numeric">
                                        <label for="price_from">Giá từ</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="price_to" name="price_to" type="text" maxlength="11" autocomplete="off" class="auto-numeric">
                                        <label for="price_to">Đến</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="create_from" name="create_from" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="create_from">Ngày tạo</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="create_to" name="create_to" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="create_to">Đến ngày</label>
                                    </div>

                                                                       
                                </div>
                            </div>
                        </li>                        
                      </ul>
                </div>
            </div>
        </div>

        <div id="wrap-list" class="card">
            {$this->element('../Product/list')}
        </div>
    </form>
</div>
