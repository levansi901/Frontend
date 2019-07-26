<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
           Nhập hàng mới
        </span>
    </div>
</div>

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
                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span>
                                Số lượng
                            </span>
                            <span id="label-total-quantity" data-total-quantity="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span>
                                Tổng tiền
                            </span>
                            <span id="label-total" data-total=""  class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <a id="btn-bill-discount" href="javascript:">
                                Chiết khấu (F6)
                                <i class="material-icons v-align-b">arrow_drop_down</i>
                            </a>
                            <span id="label-total-discount" data-total-discount="" data-discount="" data-type-discount="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <a id="btn-bill-fee-other" href="javascript:">
                                Chi phí khác (F7)
                                <i class="material-icons v-align-b">arrow_drop_down</i>
                            </a>
                            <span id="label-total-other" data-total-other="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p">
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
                    <span class="page-title no-m lh-20">
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
                    <span class="page-title no-m lh-20">
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

        <div class="hide">
            <input id="data_total_other" name="data_total_other" type="hidden" value="" />
        </div>
    </form>
</div>

{$this->element('/bill/template_row')}
{$this->element('/layout/popover_item')}
{$this->element('/layout/popover_discount')}

<div id="modal-fee-other" class="modal">
    <div class="modal-header">
        Chi phí khác
        <i class="material-icons f-s-14 lh-36 right modal-close">close</i>
    </div>
    <div class="modal-content p-xxs">
        <div id="list-fee-other">
            <div class="row">
                <div class="input-field col w-65">
                    <input type="text" autocomplete="off" value="" class="name-fee-other">
                    <label class="alway-active">Tên chi phí</label>
                </div>
                <div class="input-field col w-30">
                    <input type="text" autocomplete="off" value="" class="auto-numeric right-align fee-other">
                    <label class="alway-active">Chi phí</label>
                </div>
                <div class="input-field col w-5 no-p center-align delete-fee-other">
                    <i class="material-icons f-s-13 lh-45">close</i>
                </div>
            </div>
        </div>

        <div class="row no-m">
            <div class="col w-65">
                <a id="btn-add-fee-other" class="waves-effect waves-light btn green m-b-xs">
                    <i class="material-icons left">add</i>
                    Thêm chi phí
                </a>
            </div>
            <div class="col w-30">
                Tổng: <span id="label-total-fee-other" class="right-align"></span>
            </div>            
        </div>
    </div>
    <div class="modal-footer">
        <a id="btn-save-fee-other" class="waves-effect waves-light btn s6">
            Đồng ý
        </a>
        <a class="modal-close waves-effect waves-light btn black m-r-xs s6">
            Đóng
        </a>        
    </div>   
</div>
