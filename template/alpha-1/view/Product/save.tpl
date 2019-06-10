{assign var=data_breadcrumb value=[
0=>['title'=> 'Danh sách', 'url' => '/product'],
1=>['title'=> "{$title_view}", 'url' => ""]
]}

{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
	<div class="card">
        <div class="card-content my-form">
            <span class="card-title">Thông tin chính</span>
            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <input id="name" name="name" type="text" maxlength="255" autocomplete="off">
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

    <div class="card">
        <div class="card-content">
            <div class="row">
                <span class="waves-effect waves-light btn green m-b-xs">
                    <i class="material-icons left">add</i>
                    Thêm mới
                </span>
            </div>
        </div>
    </div>


    <div class="mn-header navbar-fixed">
        <nav class="blue-grey darken-4 nav-action">
            <div class="nav-wrapper">

                <input id="redirect-list" type="checkbox" class="filled-in"/>
                <label for="redirect-list">Về trang danh sách</label>

                <input id="redirect-form" type="checkbox" class="filled-in"/>
                <label for="redirect-form">Về trang thêm mới</label>

                <span class="waves-effect waves-light btn green m-b-xs">
                    <i class="material-icons left">add</i>
                    Thêm mới
                </span>

                <span class="waves-effect waves-light btn m-b-xs">
                    <i class="material-icons left">add</i>
                    Hủy bỏ
                </span>
            </div>
        </nav>
    </div>
</div>