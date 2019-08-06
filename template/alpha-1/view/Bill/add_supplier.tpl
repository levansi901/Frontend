<div class="row m-b-xs">
    <div class="col s6 m6 l6 no-p">
        <span class="page-title no-m">
           Nhập hàng mới
        </span>
    </div>
</div>

<div class="progress-bar-step">
    <div class="progress-bar-item">
        <div class="progress-bar-item-title">
            Đặt hàng
        </div>
        <div class="progress-bar-item-line"></div>
        <div class="progress-bar-item-ico">
            <div class="progress-bar-item-ico-in active">
                <i class="material-icons">check</i>
            </div>
        </div>
        <div class="progress-bar-item-line"></div>
        <div class="progress-bar-item-date">29/07/2019 21:53</div>
    </div>
    <div class="progress-bar-item">
        <div class="progress-bar-item-title">
            Duyệt
        </div>
        <div class="progress-bar-item-line "></div>
        <div class="progress-bar-item-ico">
            <div class="progress-bar-item-ico-in">
                <i class="material-icons">check</i>
            </div>
        </div>
        <div class="progress-bar-item-line"></div>
        <div class="progress-bar-item-date"></div>
    </div>
    <div class="progress-bar-item">
        <div class="progress-bar-item-title">
            Nhập kho
        </div>
        <div class="progress-bar-item-line "></div>
        <div class="progress-bar-item-ico">
            <div class="progress-bar-item-ico-in">
                <i class="material-icons">check</i>
            </div>
        </div>
        <div class="progress-bar-item-line"></div>
        <div class="progress-bar-item-date"></div>
    </div>
    <div class="progress-bar-item">
        <div class="progress-bar-item-title">
            Hoàn thành
        </div>
        <div class="progress-bar-item-date"></div>

        <div class="progress-bar-item-line"></div>
        <div class="progress-bar-item-ico">
            <div class="progress-bar-item-ico-in">
                <i class="material-icons">check</i>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <form id="bill-form" role="form" action="" method="POST" enctype="multipart/form-data">
        <div class="col s12 m9 l9">
            <div class="card">    
                <div class="card-content p-b-0">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input id="filter_product" type="text" maxlength="255" autocomplete="off" value="" shortcut="114">
                            <label for="filter_product">
                                Tìm kiếm sản phẩm (F3)
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
                            <a id="btn-bill-discount" href="javascript:" shortcut="117">
                                Chiết khấu (F6)
                                <i class="material-icons v-align-b">arrow_drop_down</i>
                            </a>
                            <span id="label-total-discount" data-total-discount="" data-discount="" data-type-discount="" class="right m-r-md">
                                0
                            </span>
                        </div>

                        <div class="col s6 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <a id="btn-bill-fee-other" href="javascript:" shortcut="118">
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
                    <div class="row no-m">
                        <span class="page-title no-m lh-20">
                           Thanh toán
                        </span>           
                        <div class="switch right-align">
                            <label>
                                <input id="payment-confirm" type="checkbox">
                                <span class="lever"></span>
                                Thanh toán cho nhà cung cấp
                            </label>
                        </div>
                    </div>

                    <div id="wrap-payment" class="row no-m hide">
                        <div class="input-field col s12 m6 l6">
                            {$this->Form->select('payment_method_id', $payment_method , ['name'=>'payment_method_id', 'empty' => '-- Chọn --', 'default' => '' , 'class' => ''])}
                            <label for="payment_method_id">Hình thức thanh toán</label>
                        </div>

                        <div class="input-field col s12 m6 l6">
                            <input id="payment_amount" name="payment_amount" type="text" autocomplete="off" value="" class="auto-numeric">
                            <label for="payment_amount">
                                Số tiền thanh toán
                            </label>
                        </div>

                        <div class="input-field col s12 m6 l6">
                            <input id="code_reference" name="code_reference" type="text" autocomplete="off" value="" class="">
                            <label for="code_reference">
                                Mã tham chiếu
                            </label>
                        </div>
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
                            {$this->Form->select('shop_id', $list_shop , ['name'=>'shop_id', 'empty' => null, 'default' => '' , 'class' => ''])}
                            <label for="shop_id">Chi nhánh</label>
                        </div>

                        <div id="wrap-input-supplier" class="input-field col s12 m12 l12">
                            <input id="supplier-suggest" type="text" autocomplete="off" value="" shortcut="115" placeholder="Tìm nhà cung cấp (F4)">
                            <label for="supplier" class="alway-active">
                                Nhà cung cấp
                                <small class="label-required text-red">*</small>
                            </label>
                            <i id="btn-quick-add-supplier" class="material-icons teal-text btn-input-field" title="Thêm nhà cung cấp">add</i>
                            <input id="supplier_id" name="supplier_id" value="" type="hidden" />
                        </div>
                        
                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" autocomplete="off" value="" class="">
                            <label for="name">
                                Người gửi
                            </label>
                        </div>

                        <div class="input-field col s12 m12 l12">
                            <input id="supplier" name="supplier" type="text" autocomplete="off" value="" class="">
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
                <div class="row">
                    <div class="col s12 m12 l8">

                    </div>  

                    <div class="col s12 m12 l4 center">
                        <span class="waves-effect waves-light btn s6 m-r-xs m-l-lg btn-submit-form" data-step="2">
                            <i class="material-icons left lh-36">check</i>
                            Đặt hàng và duyệt (F1)
                        </span>

                        <span class="waves-effect waves-light btn s6 m-r-xs btn-submit-form" data-step="1">
                            Đặt hàng
                        </span>
                    </div>
                </div>
            </nav>
        </div>

        <div class="hide">
            <input id="data_fee_other" name="data_fee_other" type="hidden" value="" />
            <input id="submit_step" name="submit_step" type="hidden" value="" />
        </div>
    </form>
</div>

{$this->element('/bill/template_row')}
{$this->element('/bill/popover_item')}
{$this->element('/bill/popover_discount')}
{$this->element('/bill/modal_fee_other')}
{$this->element('/bill/modal_add_supplier')}
