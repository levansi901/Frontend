<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
           Nhập hàng mới
        </span>
    </div>
</div>
<div class="my-button">reference</div>
<div class="my-popper">popper</div>
<div class="row">
    <form id="bill-form" role="form" action="" method="POST" enctype="multipart/form-data">
        <div class="col s12 m9 l9">
            <div class="card">    
                <div class="card-content p-b-0">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input id="filter_product" type="text" maxlength="255" autocomplete="off" value="">
                            <label for="filter_product">
                                Tìm kiếm sản phẩm (F4)
                            </label>
                        </div>
                    </div> 

                    <div class="row no-m">
                        <table id="bill-table" class="display responsive-table custom-table">
                            <thead>
                                <tr>
                                    <th class="w-18 left-align">                    
                                        Mã
                                    </th>

                                    <th class="w-40 left-align">
                                        Sản phẩm
                                    </th>

                                    <th class="w-15 right-align"> 
                                        Giá nhập
                                    </th>

                                    <th class="w-12 right-align"> 
                                        Số lượng
                                    </th>
                                    
                                    <th class="w-13 right-align">Thành tiền</th>
                                    <th class="w-1"></th>
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
                </div>
                <div class="card-action">
                    <div class="row no-m f-s-13">
                        <div class="col s6 m6 l5 offset-l7 offset-m6 no-p m-b-xs">
                            <span>
                                Số lượng
                            </span>
                            <span id="label-total-quantity" data-total-quantity="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l5 offset-l7 offset-m6 no-p m-b-xs">
                            <span>
                                Tổng tiền
                            </span>
                            <span id="label-total" data-total=""  class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l5 offset-l7 offset-m6 no-p m-b-xs">
                            <span>
                                Chiết khấu
                            </span>
                            <span id="label-total-discount" data-total-discount="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l5 offset-l7 offset-m6 no-p m-b-xs">
                            <span>
                                Chi phí khác
                            </span>
                            <span id="label-total-other" data-total-other="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l5 offset-l7 offset-m6 no-p">
                            <span>
                                Tiền cần trả
                            </span>
                            <span id="label-total-final" data-total-final="" class="right m-r-md">
                                0
                            </span>
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

        <div class="col s12 m3 l3">
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
        <tr data-id="">
            <td data-code="" class="left-align"></td>

            <td data-name="" class="left-align"></td>

            <td data-price="" class="left-align">
                <input id="price" type="text" maxlength="12" autocomplete="off" value="" class="auto-numeric f-s-12 right-align">
            </td>

            <td data-quantity="1" class="left-align">
                <input id="quantity" type="text" maxlength="12" autocomplete="off" value="1" class="auto-numeric f-s-12 right-align">
            </td>

            <td data-row-total="" class="right-align"></td>

            <td class="center no-p">
                <i class="material-icons f-s-14 center remove-item">close</i>
            </td>
        </tr>
    </tbody>
</table>

<div id="popover-item">
    <div class="row popover-item">
        <div class="input-field col s12 m12 l12">
            <input id="popover-item-price" type="text" autocomplete="off" value="">
            <label for="popover-item-price">
                Đơn giá 
            </label>
        </div>

        <div class="input-field col s12 m12 l12">
            <input id="popover-item-discount" type="text" autocomplete="off" value="">
            <label for="popover-item-discount">
                Chiết khấu thường
            </label>
        </div>

        <div class="input-field col s12 m12 l12">
            <input id="popover-item-vat" type="text" autocomplete="off" value="">
            <label for="popover-item-vat">
                Thuế (%)
            </label>
        </div>
    </div>
</div>

<div id="popover-discount">
    <div class="row popover-item">
        <div class="input-field col s12 m12 l12">
            <input id="popover-item-discount" type="text" autocomplete="off" value="">
            <label for="popover-item-discount">
                Chiết khấu thường
            </label>
        </div>
    </div>
</div>