<?php

namespace App\Controller;
use Cake\Network\Http\Client;

class ProductController extends AppController
{

    public function initialize()
    {
        parent::initialize();
        $this->set('title_for_layout', 'Sản phẩm');

    }

    public function index(){    	

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'product/inital-data-form-list');  
        $result = $response->json;
        $data = !empty($result['data']) ? $result['data'] : [];
        $list_status = $products = [];
        if(!empty($data)){
        	$list_status = !empty($data['list_status']) ? $data['list_status'] : [];
        	$products = !empty($data['products']) ? $data['products'] : [];
        }
        
        $this->set('list_status', $list_status);
        $this->set('products', $products);

    }

    public function ajaxListProduct(){
    	//param default
        $params = array(
            'id_filter' => '',
            'keyword' => '',
            'category_filter' => '',
            'status' => '',
            'brand_id' => '',
            'available_stock' => '',
            'price_from' => '',
            'price_to' => '',
            'image_filter' => '',
            'create_by' => '',
            'create_from' => '',
            'create_to' => '',
            'page' => 1,
            'sort' => 'Product.id',
            'direction' => 'DESC',
            'format' => '',
            'limit' => PAGE_DEFAULT,
            'lang' => LANG_DEFAULT,            
        );

        // mere data port from view
        $data_post = [];
        if ($this->request->is('post') && !empty($this->data)) {
            $data_post = $this->data;
            $params = array_merge($params, $data_post);
        }
    }

    public function saveProduct($id = null){

        $title_view = 'Thêm sản phẩm mới';
        if(!empty($id)){
            $title_view = 'Sửa sản phẩm';
        }

        
        // get data inital
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'product/inital-data-form');  
        $result = $response->json;
        $data = !empty($result['data']) ? $result['data'] : [];
        $list_status = [];
        if(!empty($data)){
            $list_status = !empty($data['list_status']) ? $data['list_status'] : [];
        }

        $this->set('list_status', $list_status);
        $this->set('title_view', $title_view);
        $this->set('title_for_layout', $title_view);
        $this->render('save');
    }

    public function ajaxSaveProduct(){

    }

    public function ajaxUpdateStatus(){
    	
    }

    public function ajaxDeleteProduct(){

    }



    public function productExport(){


    }	


































}
