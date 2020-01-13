{assign var=data_breadcrumb value=[
0=>['title' => 'Danh sách', 'url' => '/inventory/bill'],
1=>['title' => "{$title_for_layout}", 'url' => ""]
]}

{$this->element('/layout/breadcrumb', ['data'=> $data_breadcrumb])}

<div class="row row-offset">
    <form id="bill-form" role="form" action="" method="POST" enctype="multipart/form-data">    
        <div class="col s12 m12 l12">
            <div class="row row-offset m-b-0">
                <div class="col s12 m6 l6">
                    
                </div>
                <div class="col s12 m6 l6">
                    {$this->element('/bill/status_line')}
                </div>
            </div>
            

            <div class="row row-offset m-b-0">
                <div class="col s12 m6 l6">
                    <div class="card m-b-xxs">    
                        <div class="card-content">
                            <div class="row card-title no-m">                
                                <div class="col s12 m12 l12">
                                    <i class="material-icons">dvr</i>
                                    Thông tin phiếu
                                </div>
                            </div>

                            <hr>

                            <div class="row no-m">                    
                                <div class="col s12 m6 l6 m-t-xs">
                                    <span>
                                        Mã phiếu: 
                                        {if !empty($bill.code)}
                                            <span class="teal-text">{$bill.code}</span>
                                        {/if}
                                    </span>
                                </div>   

                                <div class="col s12 m6 l6 m-t-xs">
                                    <span>
                                        Ngày tạo: 
                                        {if !empty($bill.created)}
                                            <i class="f-s-13">{date('H:i - d/m/Y', strtotime($bill.created))}</i>
                                        {/if}
                                    </span>
                                </div>                     
                                
                                <div class="col s12 m6 l6 m-t-xs">
                                    <span>
                                        Loại phiếu: 
                                        {if !empty($bill.type) && !empty($bill.type_receipt)}
                                            <span class="text-capitalize teal-text">
                                                {if $bill.type == 'IMPORT'}
                                                    Nhập
                                                {/if}

                                                {if $bill.type == 'EXPORT'}
                                                    Xuất
                                                {/if}

                                                {if !empty($list_type_receipt[$bill.type_receipt])}
                                                    {$list_type_receipt[$bill.type_receipt]}
                                                {/if}
                                            </span>  
                                        {/if}
                                    </span>
                                </div>

                                <div class="col s12 m6 l6 m-t-xs">
                                    <span>
                                        Trạng thái: {if !empty($bill.sender)}{$bill.sender}{/if}
                                    </span>
                                </div>
                                
                                <div class="col s12 m12 l12 m-t-xs">                            
                                    <span>
                                        Người gửi: {if !empty($bill.sender)}{$bill.sender}{/if}
                                    </span>
                                </div>
                                                    
                                <div class="col s12 m12 l12 m-t-xs">                            
                                    <span>
                                        Người nhận: {if !empty($bill.receiver)}{$bill.receiver}{/if}
                                    </span>
                                </div>                        
                            
                                <div class="col s12 m12 l12 m-t-xs">                            
                                    <span>
                                        Ghi chú: {if !empty($bill.note)}{$bill.note}{/if}
                                    </span>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col s12 m6 l6">
                    {if !empty($supplier)}
                        <div class="card m-b-xxs">    
                            <div class="card-content">
                                <div class="row card-title no-m">                
                                    <div class="col s12 m12 l12">
                                        <i class="material-icons">person_pin</i>
                                        Nhà cung cấp
                                    </div>
                                </div>

                                <hr>

                                <div class="row no-m">
                                    <div class="col s12 m12 l12 m-t-xs">                                        
                                        <span>
                                            Tên: {if !empty($supplier.name)}{$supplier.name}{/if}
                                        </span>
                                    </div>

                                    <div class="col s12 m12 l12 m-t-xs">
                                        <span>
                                            Số điện thoại: {$supplier.phone}                                
                                        </span>
                                    </div> 

                                    <div class="col s12 m12 l12 m-t-xs">
                                        <span>
                                            Địa chỉ: {$supplier.address}                                
                                        </span>
                                    </div>

                                    <div class="col s12 m12 l12 m-t-xs">
                                        <span>
                                            Công nợ: <span class="text-red">0</span>                             
                                        </span>
                                    </div>

                                    <div class="col s12 m12 l12 m-t-xs hide-on-small-only">
                                        <span>
                                            &nbsp;             
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}
                </div>
            </div>                    

            <div class="card">
                <div class="card-content p-b-0">
                    <div class="row no-m">
                        <div class="table-responsive">
                            <table id="bill-table" class="display custom-table">
                                <thead>
                                    <tr>
                                        <th class="w-15 left-align">                    
                                            Mã
                                        </th>

                                        <th class="w-30 left-align">
                                            Sản phẩm
                                        </th>

                                        <th class="w-10 right-align"> 
                                            Số lượng
                                        </th>

                                        <th class="w-15 right-align"> 
                                            Giá
                                        </th>

                                        <th class="w-10 right-align"> 
                                            Chiết khấu
                                        </th>

                                        <th class="w-10 right-align"> 
                                            Thuế
                                        </th>                                        
                                        
                                        <th class="w-15 right-align">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {if !empty($items)}
                                        {foreach from = $items item = item}
                                            <tr>
                                                <td class="left-align">
                                                    {if !empty($item.code)}
                                                        {$item.code}
                                                    {/if}
                                                </td>

                                                <td class="left-align">
                                                    {if !empty($item.product_name)}
                                                        {$item.product_name}
                                                    {/if}                                                
                                                </td>

                                                <td class="right-align">
                                                    {if !empty($item.quantity)}
                                                        {$item.quantity|number_format:0:".":","}
                                                    {/if}
                                                </td>

                                                <td class="right-align">
                                                    {if !empty(floatval($item.price))}
                                                        {$item.price|number_format:0:".":","}
                                                    {/if}
                                                </td>

                                                <td class="right-align">
                                                    {if !empty(floatval($item.total_discount))}
                                                        {$item.total_discount|number_format:0:".":","}
                                                    {/if}
                                                </td>

                                                <td class="right-align">
                                                    {if !empty(floatval($item.total_vat))}
                                                        {$item.total_vat|number_format:0:".":","}
                                                    {/if}
                                                </td>

                                                <td class="right-align">
                                                    {if !empty(floatval($item.total))}
                                                        {$item.total|number_format:0:".":","}
                                                    {/if}
                                                </td>
                                            </tr>
                                        {/foreach}
                                    {else}
                                        <tr class="no-record">
                                            <td colspan="12" class="center">
                                                <i>
                                                    Không tìm thấy thông tin sản phẩm
                                                </i>
                                            </td>                            
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                        </div>
                    </div>                   
                </div>

                <div class="card-action">
                    <div class="row no-m f-s-13">                        
                        <div class="col s12 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span>
                                Tổng tiền
                            </span>
                            <span class="right m-r-xxs">
                                {if !empty($bill.total)}
                                    {$bill.total|number_format:0:".":","}
                                {/if}
                            </span>
                        </div>

                        <div class="col s12 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span>
                                VAT
                            </span>
                            <span class="right m-r-xxs">
                                {if !empty($bill.total_vat)}
                                    {$bill.total_vat|number_format:0:".":","}
                                {/if}
                            </span>
                        </div>

                        <div class="col s12 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span>
                                Chiết khấu
                            </span>
                            <span class="right m-r-xxs">
                                {if !empty($bill.total_discount)}
                                    {$bill.total_discount|number_format:0:".":","}
                                {else}
                                    0
                                {/if}
                            </span>
                        </div>
                        {assign var = html_other_info value = ''}
                        {if !empty($bill.fee_other_info)}
                            {foreach from = $bill.fee_other_info item = other_info}
                                {assign var = html_other_info value = "{$html_other_info} <p class='no-m f-s-11'>{$other_info.name}: {if !empty($other_info.fee)}{$other_info.fee|number_format:0:".":","}{else}0{/if}</p>"}
                            {/foreach}
                        {/if}

                        <div class="col s12 m6 l4 offset-l8 offset-m6 no-p m-b-xs">
                            <span class="{if !empty($html_other_info)}tooltipped fake-link{/if}" data-position="right" data-tooltip="{$html_other_info}" data-html="true">
                                Chi phí khác
                            </span>
                            <span class="right m-r-xxs">
                                {if !empty($bill.fee_other)}
                                    {$bill.fee_other|number_format:0:".":","}
                                {else}
                                    0
                                {/if}
                            </span>
                        </div>

                        <div class="col s12 m6 l4 offset-l8 offset-m6 no-p">
                            <span>
                                Tiền cần trả
                            </span>
                            <span class="right m-r-xxs text-red">
                                {if !empty($bill.total_final)}
                                    {$bill.total_final|number_format:0:".":","}
                                {/if}
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
                                Thanh toán ngay
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

            <div class="card m-b-xxl">
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

        <div class="mn-header navbar-fixed">
            <nav class="white nav-action">
                <div class="row">
                    <div class="col s12 m12 l12 center no-p">
                        <span class="waves-effect waves-light btn s6 m-r-xxs p-h-xs btn-submit-form" data-step="2">
                            <i class="material-icons left lh-36 m-r-xxs">done_all</i>
                            Đặt và duyệt (F1)
                        </span>

                        <span class="waves-effect waves-light btn s6 p-h-xs btn-submit-form" data-step="1">
                            <i class="material-icons left lh-36 m-r-xxs">check</i>
                            Đặt hàng (F2)
                        </span>
                    </div>
                </div>
            </nav>
        </div>

    </form>
</div>
