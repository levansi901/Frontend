{assign var=data_breadcrumb value=[0=>['title'=> {$title_for_layout},'url' => ""]]}
{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="row no-m">
    <form id="form-list-data" action="/product/list" class="no-m no-p">    
    	<div id="wrap-filter" class="card no-m">
            <div class="card-content p-v-xs p-h-xs">
            	<div class="row no-m">
                    <div class="input-field col s12 m4 l3">
                        <input id="keyword" name="keyword" type="text" maxlength="100" autocomplete="off">
                        <label for="keyword">Tên / Mã sản phẩm</label>
                    </div>
                    <div class="input-field col s12 m12 l3">
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

                    <!-- <a href="/product/add" class="waves-effect waves-light btn m-b-xs m-r-xxs" title="Thêm sản phẩm mới">
                        <i class="material-icons left">add</i>
                        Thêm sản phẩm mới
                    </a>   -->
                    <!-- <a data-activates="setting-list" class="dropdown-button btn-floating br-2 btn waves-effect waves-light m-b-xs" title="Hành động">
                        <i class="material-icons">settings</i>
                    </a>
                    <ul id="setting-list" class="dropdown-content">
                        <li>
                            <a title="Giảm giá đồng loạt">
                                <i class="material-icons left">card_giftcard</i>
                                Giảm giá đồng loạt
                            </a>   
                        </li>                                           
                        <li class="divider"></li>
                        <li>
                            <a id="delete-selected" title="Xóa sản phẩm">
                                <i class="material-icons left text-red">delete_forever</i>
                                Xóa
                            </a>                                            
                        </li>
                    </ul> -->
                </div>

                <div class="row no-m p-h-xs">
                     <ul id="wrap-more-filter" class="collapsible no-m">
                        <li>
                            <div class="collapsible-body">
                                <div class="row no-m p-v-xs">
                                    <div class="input-field col s12 m4 l3">
                                        <input id="price_from" name="price_from" type="text" maxlength="11" autocomplete="off" class="auto-numeric">
                                        <label for="price_from">Giá từ</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="price_to" name="price_to" type="text" maxlength="11" autocomplete="off" class="auto-numeric">
                                        <label for="price_to">Đến</label>
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
                                        <input id="create_from" name="create_from" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="create_from">Ngày tạo</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="create_to" name="create_to" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="create_to">Đến ngày</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">   
                                        {$this->Form->select('brand_id', $list_brands , ['name'=>'brand_id', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="brand_id">Thương hiệu</label>
                                    </div>                                    
                                </div>
                            </div>
                        </li>                        
                      </ul>
                </div>
            </div>
        </div>

        <div id="wrap-list" class="card">
            {$this->element('../Order/list')}
        </div>
    </form>
</div>
