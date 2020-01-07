<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
            Phiếu xuất/nhập kho
        </span>        
    </div>
    <div class="col s6 m6 l6 no-p right-align">
        <a href="/inventory/add-supplier" class="waves-effect waves-light btn" title="Tạo phiếu mới">
            <i class="material-icons left">add</i>
            Tạo phiếu
        </a>
    </div>    
</div>
  
<div class="row no-m">
    <form id="form-list-data" action="/inventory/bill/list" class="no-m no-p">    
        <div id="wrap-filter" class="card no-m">
            <div class="card-content p-v-xs p-h-xs m-b-xs p-b-0">
                <div class="row no-m">
                    <div class="input-field col s12 m2 l2">
                        <input id="code" name="code" type="text" maxlength="20" autocomplete="off">
                        <label for="code">Mã phiếu</label>
                    </div>

                    <div class="input-field col s12 m4 l3">
                        <input id="product_filter" name="product_filter" type="text" maxlength="100" autocomplete="off">
                        <label for="product_filter">Sản phẩm</label>
                    </div>

                    <div class="input-field col s12 m4 l2">
                        {$this->Form->select('type', $list_type_bill , ['name'=>'type', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                        <label for="type">Loại phiếu</label>                        
                    </div>               

                    <div class="input-field col s12 m4 l2">
                        {$this->Form->select('type_receipt', $list_type_receipt , ['name'=>'type_receipt', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                        <label for="type_receipt">Kiểu phiếu</label>
                    </div>

                    <div class="input-field col s12 m4 l3 right-align">
                        <a id="filter-data" class="waves-effect waves-light btn m-b-xs m-r-xxs" title="Tìm kiếm">
                            <i class="material-icons left">search</i>                            
                            Tìm kiếm
                        </a>

                        <a id="reset-filter" class="btn-floating waves-effect waves-effect waves-light m-b-xs" title="Làm mới">
                            <i class="material-icons">refresh</i>
                        </a>

                        <a id="more-filter" class="btn-floating waves-effect waves-effect blue-grey darken-4 m-b-xs" title="Hiển thị bộ lọc khác">
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
                                        {$this->Form->select('shop_id', $list_shops , ['name'=>'shop_id', 'empty' => "-- Chọn --", 'default' => '' , 'class' => ''])}
                                        <label for="shop_id">Chi nhánh</label>
                                    </div>                                    

                                    <div class="input-field col s12 m4 l3">
                                        <input id="supplier-suggest" type="text" autocomplete="off">
                                        <label for="supplier-suggest">Nhà cung cấp</label>
                                        <input id="supplier_id" name="supplier_id" type="hidden" autocomplete="off">
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="created-by-suggest" type="text" autocomplete="off">
                                        <label for="created-by-suggest">Người tạo</label>
                                        <input id="created_by" name="created_by" type="hidden" autocomplete="off">
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="created_from" name="created_from" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="created_from">Ngày tạo</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="created_to" name="created_to" type="text" maxlength="11" autocomplete="off" class="input-date-picker">
                                        <label for="created_to">Đến ngày</label>
                                    </div>

                                    <div class="input-field col s12 m4 l3">
                                        <input id="note" name="note" type="text" autocomplete="off">
                                        <label for="note">Ghi chú</label>
                                    </div>
                                </div>
                            </div>
                        </li>                        
                      </ul>
                </div>
            </div>
        </div>

        <div id="wrap-list" class="card">
            {$this->element('../Inventory/list')}
        </div>
    </form>
</div>
