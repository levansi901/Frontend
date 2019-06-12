{assign var=data_breadcrumb value=[
0=>['title'=> 'Danh sách', 'url' => '/product'],
1=>['title'=> "{$title_view}", 'url' => ""]
]}

{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
	<div class="card">
        <div class="card-content my-form">
            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="name" name="name" type="text" maxlength="255" autocomplete="off" value="{if !empty($product.name)}{$product.name}{/if}">
                    <label for="name">Tên sản phẩm</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="lazada_category_id" name="lazada_category_id" type="text" autocomplete="off">
                    <label for="lazada_brand_id">Danh mục Lazada</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="lazada_brand_id" name="lazada_brand_id" type="text" maxlength="255" autocomplete="off">
                    <label for="lazada_brand_id">Thương hiệu Lazada</label>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Phiên bản sản phẩm</span>
            <div class="row">
                <table class="display responsive-table dataTable custom-table">
                    <thead>
                        <tr>
                            <th rowspan="2">
                                <input id="check-all" type="checkbox" class="filled-in"/>
                                <label for="check-all"></label>
                            </th>
                            <th rowspan="2">
                            </th>
                            <th rowspan="2">Tên sản phẩm</th>
                            <th colspan="4">Phiên bản sản phẩm</th>
                            <th rowspan="2">Tồn kho</th>
                            <th rowspan="2">TT</th>
                            <th rowspan="2"></th>
                        </tr>

                        <tr>
                            <th> 
                                Thuộc tính
                            </th>

                            <th> 
                                Mã
                            </th>

                            <th> 
                                Mã vạch
                            </th>

                            <th> 
                                Giá
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input id="row-1" type="checkbox" class="filled-in"/>
                                <label for="row-1"></label>
                            </td>
                            <td>
                            </td>
                            <td>
                                SHEIN Áo hai dây Nút Nhiệt đới Nhiều màu Boho
                            </td>
                            <td>
                                
                            </td>
                            <td>
                                NH_00331
                            </td>
                            <td>
                                0123456789
                            </td>
                            <td>
                                120,000
                            </td>
                            <td>
                                10
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>                    
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Thuộc tính Lazada</span>
            <div class="row">
  
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Thông tin khác</span>
            <div class="row">
                <div class="input-field col s12 m4 l3">
                    {$this->Form->select('status',$list_status , ['name'=>'status','empty' => "Trạng thái",'default' => {"{if !empty($product.status)}{$product.status}{/if}"} ,'class' => ''])}
                    <label>Trạng thái</label>
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

    <div class="card">
        <div class="card-content my-form">
            <span class="card-title">Mô tả sản phẩm</span>
            <div class="row">
  
            </div>
        </div>
    </div>

    <div class="mn-header navbar-fixed">
        <nav class="white nav-action">
            <div class="row center">
                <span class="p-v-xs hide-on-small-only">
                    <input id="redirect-list" name="after_save" type="radio" checked="true" />
                    <label for="redirect-list">Về trang danh sách</label>
                </span>
                <span class="p-v-xs hide-on-small-only">
                    <input id="redirect-form" name="after_save" type="radio"  />
                    <label for="redirect-form">Về trang thêm mới</label>
                </span>                    

                <span class="waves-effect waves-light btn black m-l-lg s6">
                    <i class="material-icons left lh-36">close</i>
                    Hủy bỏ
                </span>

                <span class="waves-effect waves-light btn green s6">
                    <i class="material-icons left lh-36">check</i>
                    Thêm mới
                </span>
            </div>    
        </nav>
    </div>
</div>

<div id="modal-lazada-category" class="modal modal-lazada-category">
    <div class="modal-content">
        <h4>Chọn danh mục</h4>
        <div class="row group-level">
            <div class="group-wrap">
                <div class="search-wrap">
                    <div class="input-field row no-m">
                        <input type="text" class="no-m" maxlength="100" autocomplete="off" placeholder="Tìm danh mục" value="">
                    </div>
                </div>
                <ul class="list-wrap">
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>
                    <li>
                        <span class="text" title="Thể thao &amp; Hoạt động ngoài trời">Thể thao &amp; Hoạt động ngoài trời</span>
                        <i class="nav-drop-icon material-icons">keyboard_arrow_right</i>
                    </li>

                </ul>
            </div>            
        </div>
    </div>
</div>

{assign var = tree_category_id_json value = ''}
{if !empty($product.lazada_category_tree_ids)}
    {assign var = tree_category_id_json value = $product.lazada_category_tree_ids|@json_encode}
{/if}
<script type="text/javascript">
    var tree_category_id_json = "{if !empty($tree_category_id_json)}{$tree_category_id_json}{/if}";
    lazada_category.init({
        csrf_token : "{if !empty($csrf_token)}{$csrf_token}{/if}",
        tree_category_id: tree_category_id_json.length > 0 ? $.parseJSON(tree_category_id_json) : []
    }); 

</script>