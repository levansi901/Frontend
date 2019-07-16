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
                            <input id="filter_product" type="text" length="255" maxlength="255" autocomplete="off" value="">
                            <label for="name">
                                Tìm kiếm sản phẩm (F4)
                            </label>
                        </div>
                    </div> 

                    <div class="row">
                        <table id="item-table" class="display responsive-table custom-table">
                            <thead>
                                <tr>
                                    <th class="w-15 left-align">                    
                                        Mã
                                    </th>
                                    <th class="w-30 left-align">
                                        Sản phẩm
                                    </th>

                                    <th class="w-15 right-align"> 
                                        Giá nhập
                                    </th>

                                    <th class="w-15 right-align"> 
                                        Số lượng
                                    </th>
                                    <th class="w-20 right-align">Thành tiền</th>
                                    <th class="w-3"></th>
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

<table id="template-list" class="hide">
    <tbody>
        <tr>
            <td data-code="" class="left-align">

            </td>

            <td data-name="" class="left-align">

            </td>

            <td class="left-align">
                <input id="price" data-price="" type="number" length="11" maxlength="11" autocomplete="off" value="">
            </td>

            <td class="left-align">
                <input id="quantity" data-quantity="" type="number" length="11" maxlength="11" autocomplete="off" value="">
            </td>

            <td data-row-total="" class="left-align">

            </td>

            <td class="center">
                <i class="material-icons f-s-14 center remove-item">close</i>
            </td>
        </tr>
    </tbody>
</table>

