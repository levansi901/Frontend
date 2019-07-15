<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
           Nhập hàng mới
        </span>
    </div>    
</div>

<div class="row">
    <form id="bill-form" role="form" action="" method="POST" enctype="multipart/form-data">
        <div class="col s12 m8 l8">
            <div class="card">    
                <div class="card-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input id="filter_product" type="text" length="255" maxlength="255" autocomplete="off" value="" class="">
                            <label for="name">
                                Tìm kiếm sản phẩm (F4)
                            </label>
                        </div>
                    </div> 

                    <div class="row">
                        <table id="data-table" class="display responsive-table custom-table">
                            <thead>
                                <tr>
                                    <th class="w-3">
                                        <input id="select-all" type="checkbox" class="filled-in no-text"/>
                                        <label for="select-all"></label>
                                        <div id="wrap-action-list" class="hide">
                                                <a data-activates="action-list" class="dropdown-button waves-effect waves-light btn btn-action" title="Chọn hành động">
                                                <i class="material-icons left">expand_more</i>
                                                Chọn hành động
                                            </a>  
                                            <ul id="action-list" class="dropdown-content">
                                                <li class="hide">
                                                    <a title="Giảm giá đồng loạt">
                                                        <i class="material-icons left">card_giftcard</i>
                                                        Giảm giá đồng loạt
                                                    </a>
                                                </li>

                                                <li>
                                                    <a class="change-status-selected" data-status="1" title="Kích hoạt sản phẩm">
                                                        <i class="material-icons f-s-14 text-green">check</i>
                                                        Hoạt động
                                                    </a>   
                                                </li>

                                                <li>
                                                    <a class="change-status-selected" data-status="0" title="Tạm ngừng hoạt động sản phẩm">
                                                        <i class="material-icons f-s-14">no_encryption</i>
                                                        Không hoạt động
                                                    </a>   
                                                </li>

                                                <li class="divider"></li>
                                                <li>
                                                    <a class="delete-selected" title="Xóa sản phẩm">
                                                        <i class="material-icons left text-red">delete_forever</i>
                                                        Xóa
                                                    </a>                                            
                                                </li>
                                            </ul>
                                        </div>
                                    </th>
                                    <th class="w-3">                    
                                        
                                    </th>
                                    <th class="w-30 left-align {if !empty($params.sort) && !empty($params.direction) && $params.sort == name}sorting_{$params.direction}{else}sorting{/if}" data-sort="name">
                                        Sản phẩm
                                    </th>

                                    <th class="w-15 left-align"> 
                                        Mã
                                    </th>

                                    <th class="w-15 {if !empty($params.sort) && !empty($params.direction) && $params.sort == price}sorting_{$params.direction}{else}sorting{/if}" data-sort="price"> 
                                        Giá
                                    </th>

                                    <th class="w-15 {if !empty($params.sort) && !empty($params.direction) && $params.sort == price_discount}sorting_{$params.direction}{else}sorting{/if}" data-sort="price_discount" title="Giá khuyến mãi"> 
                                        Giá KM
                                    </th>
                                    <th class="w-10">Tồn</th>
                                    <th class="w-3">TT</th>
                                </tr>
                            </thead>
                            <tbody>                    
                                <tr class="no-record">
                                    <td colspan="12" class="center">
                                        <i>
                                            Hãy chọn 1 sản phẩm
                                        </i>
                                    </td>                            
                                </tr>
                            </tbody>
                        </table>                    
                    </div>

                    <div class="row">
                        <div class="col s12 m6 l4">

                        </div>
                    </div>
                    
                </div>
            </div>

            <div class="card">    
                <div class="card-content">     
                    <span class="page-title no-m">
                       Thanh toán
                    </span>           
                    <div class="switch right-align">
                        <label>
                            <input type="checkbox">
                            <span class="lever"></span>
                            Thanh toán cho nhà cung cấp
                        </label>
                    </div>
                </div>
            </div>

            <div class="card">    
                <div class="card-content">     
                    <span class="page-title no-m">
                       Nhập hàng
                    </span>           
                    <div class="switch right-align">
                        <label>
                            <input type="checkbox">
                            <span class="lever"></span>
                            Nhập hàng vào kho
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <div class="col s12 m4 l4">
            <div class="card">    
                <div class="card-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            {$this->Form->select('shop_id', $list_shops , ['name'=>'shop_id', 'empty' => null, 'default' => '' , 'class' => ''])}
                            <label for="shop_id">Chi nhánh</label>
                        </div>

                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" length="255" maxlength="255" autocomplete="off" value="" class="">
                            <label for="supplier">
                                Nhà cung cấp
                            </label>
                        </div>

                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" length="255" maxlength="255" autocomplete="off" value="" class="">
                            <label for="name">
                                Người gửi
                            </label>
                        </div>

                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" length="255" maxlength="255" autocomplete="off" value="" class="">
                            <label for="name">
                                Người nhận
                            </label>
                        </div>

                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" length="255" maxlength="255" autocomplete="off" value="" class="">
                            <label for="name">
                                Ghi chú
                            </label>
                        </div>
                    </div> 
                    
                </div>
            </div>
        </div>

        <div class="mn-header navbar-fixed">
            <nav class="white nav-action">
                <div class="row right-align">                        

                    <span class="waves-effect waves-light btn s6 blue-grey darken-4">
                        <i class="material-icons left lh-36">close</i>
                        Hủy
                    </span>

                    <span class="waves-effect waves-light btn s6 m-l-lg m-r-xs btn-submit-form">
                        <i class="material-icons left lh-36">check</i>
                        Lưu
                    </span>
                    
                </div>    
            </nav>
        </div>
    </form>
</div>

