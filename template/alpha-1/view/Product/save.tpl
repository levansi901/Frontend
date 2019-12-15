{assign var=data_breadcrumb value=[
0=>['title'=> 'Danh sách', 'url' => '/product'],
1=>['title'=> "{$title_for_layout}", 'url' => ""]
]}

{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
    <form id="product-form" role="form" action="/product/save{if !empty($product.id)}/{$product.id}{/if}" method="POST" enctype="multipart/form-data">
    	<div class="card">
            <div class="card-content my-form">
                <div class="row">
                    <div class="input-field col s12 m12 l12">
                        <input id="name" name="name" type="text" length="255" maxlength="255" autocomplete="off" value="{if !empty($product.name)}{$product.name}{/if}" class="required">
                        <label for="name">
                            Tên sản phẩm
                            <small class="label-required text-red">*</small>
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s12 m12 l12">
                        <input id="select_lazada_category" name="select_lazada_category" type="text" autocomplete="off" readonly="true" value="{if !empty($product.lazada_category_tree_name)}{$product.lazada_category_tree_name}{/if}" class="required" >
                        <label for="select_lazada_category">
                            {$this->element('/lazada/icon')}
                            Danh mục Lazada
                            <small class="label-required text-red">*</small>               
                        </label>

                        <input type="hidden" id="lazada_category_id" name="lazada_category_id" value="{if !empty($product.lazada_category_id)}{$product.lazada_category_id}{/if}">

                        <input type="hidden" id="lazada_category_tree_ids" name="lazada_category_tree_ids" value="{if !empty($product.lazada_category_tree_ids)}{$product.lazada_category_tree_ids}{/if}">
                        
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div id="wrap-items" class="card-content my-form">
                <span class="card-title">Phiên bản sản phẩm</span>
                <div class="row">
                    <ul id="list-items" class="collapsible popout collapsible-custom" data-collapsible="expandable">
                        {if !empty($product.items)}
                            {foreach from = $product.items key=k item = item}
                                {assign var = number value = $k + 1}
                                {$this->element('../Product/item',[item => $item, number => $number])}
                            {/foreach}
                        {else}
                            {$this->element('../Product/item',[item => [], number => 1])}
                        {/if}
                    </ul>
                </div>

                <div class="row center">
                    <span id="add-item" class="waves-effect waves-light btn">
                        <i class="material-icons left">add</i>
                        Thêm phiên bản mới
                    </span>
                </div>
            </div>
        </div>    

        <div class="card">
            <div class="card-content my-form">
                <div class="row">
                    <div class="input-field col s12 m4 l3">
                        {$this->Form->select('status',$list_status , ['name'=>'status','empty' => null,'default' => {"{if !empty($product.status)}{$product.status}{/if}"} ,'class' => ''])}
                        <label for="status">Trạng thái</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s12 m4 l3">
                        <input id="width" name="width" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.width)}{$product.width}{/if}">
                        <label for="width">Chiều rộng <small>(cm)</small></label>
                    </div>

                    <div class="input-field col s12 m4 l3">
                        <input id="length" name="length" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.length)}{$product.length}{/if}">
                        <label for="length">Chiều dài <small>(cm)</small></label>
                    </div>

                    <div class="input-field col s12 m4 l3">
                        <input id="height" name="height" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.height)}{$product.height}{/if}">
                        <label for="height">Chiều cao <small>(cm)</small></label>
                    </div>

                    <div class="input-field col s12 m4 l3">
                        <input id="weight" name="weight" type="number" maxlength="11" autocomplete="off" value="{if !empty($product.weight)}{$product.weight}{/if}">
                        <label for="weight">Cân nặng <small>(gram)</small></label>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="wrap-lazada-spu-attributes" class="card {if empty($lazada_normal_attributes)}hide{/if}">
            <div class="card-content my-form">
                <span class="card-title">
                    {$this->element('/lazada/icon')}
                    Thuộc tính Lazada
                </span>
                <div class="row lazada-spu-attributes">
                    {if !empty($lazada_normal_attributes)}
                        {$this->element('../Product/lazada_attributes',['lazada_attributes' => $lazada_normal_attributes, show_icon => false])}             
                    {/if}           
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-content my-form">
                <div class="row card-title no-m">                
                    <div class="col s12 m12 l12">
                        Mô tả sản phẩm
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s12 m12 l12">
                        <textarea class="mce-editor"></textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="mn-header navbar-fixed">
            <nav class="white nav-action">
                <div class="row center">
                    <span class="p-v-xs hide-on-small-only m-r-sm">
                        <input id="redirect-list" name="after_save" type="radio" checked="true" value="list" class="with-gap" />
                        <label for="redirect-list">Về trang danh sách</label>
                    </span>

                    <span class="p-v-xs hide-on-small-only m-r-sm">
                        <input id="redirect-edit" name="after_save" type="radio" value="edit" class="with-gap" />
                        <label for="redirect-edit">Về trang cập nhât</label>
                    </span>   

                    <span class="p-v-xs hide-on-small-only">
                        <input id="redirect-add" name="after_save" type="radio" value="add" class="with-gap" />
                        <label for="redirect-add">Tiếp tục thêm mới</label>
                    </span>                 

                    <span class="waves-effect waves-light btn s6 m-l-lg m-r-xs btn-submit-form">
                        <i class="material-icons left lh-36">check</i>
                        Thêm mới
                    </span>

                    <span class="waves-effect waves-light btn s6 blue-grey darken-4">
                        <i class="material-icons left lh-36">close</i>
                        Hủy bỏ
                    </span>
                    
                </div>    
            </nav>
        </div>
    </form>
</div>

<div id="modal-lazada-category" class="modal modal-lazada-category">
    <div class="modal-content">
        <h4>Chọn danh mục</h4>
        <div class="row group-level">        
        </div>  

        <div class="row m-b-xs right">
            <a class="modal-close waves-effect waves-light btn black m-r-xs s6">Hủy bỏ</a>
            <a id="select-lazada-category" class="waves-effect waves-light btn s6 disabled">
                Đồng ý
            </a>
        </div>      
    </div>    
</div>

<script type="text/javascript">
    function OnMessage(e){
      var event = e.originalEvent;
       // Make sure the sender of the event is trusted
       if(event.data.sender === 'responsivefilemanager' && event.data.field_id){
            
            var field_id = event.data.field_id;            
            var url = event.data.url;
            // console.log(field_id);
            // console.log(event.data);
            $('#' + field_id).val(url).trigger('change');
            $.fancybox.close();

            // Delete handler of the message from ResponsiveFilemanager
            $(window).off('message', OnMessage);
       }
    }

    $('.btn-select-image').on('click',function(){
        $(window).on('message', OnMessage);
    });
</script>