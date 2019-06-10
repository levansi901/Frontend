{assign var=data_breadcrumb value=[0=>['title'=> 'Danh sách sản phẩm','url' => ""]]}
{$this->element('/layout/breadcrumb',['data'=> $data_breadcrumb])}

<div class="col s12 m12 l12">
	<div class="card">
        <div class="card-content">
        	<div class="row">
                <div class="input-field col s12 m4 l2">
                    <input id="keyword" name="keyword" type="text" maxlength="100" autocomplete="off">
                    <label for="keyword">Tên / Mã / Mã vạch sản phẩm</label>
                </div>

                <div class="input-field col s12 m4 l2">   
                	{$this->Form->select('status',$list_status , ['name'=>'status','empty' => "Trạng thái",'default' => '' ,'class' => ''])}
                    <label>Trạng thái</label>
                </div>

                

                <div class="input-field col s12 m12 l3">
                	<a class="waves-effect waves-light btn blue m-b-xs">
                		Tìm kiếm
	                </a>

	                <a class="btn-floating br-2 btn waves-effect waves-light green m-b-xs">
                		<i class="material-icons">loop</i>
	                </a>

	                <a class="btn-floating br-2 btn waves-effect waves-light blue-grey darken-4 m-b-xs">
                		<i class="material-icons">keyboard_arrow_right</i>
	                </a>
                </div>                
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-content">      
        	<div class="s12">
        		<a href="/product/add" class="waves-effect waves-light btn green m-b-xs">
        			<i class="material-icons left">add</i>
            		Thêm sản phẩm mới
                </a>				
        	</div>      
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