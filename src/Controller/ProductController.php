<?php

namespace App\Controller;
use Cake\Http\Client;


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
        static::$js_files[] = 'assets/js/pages/autoNumeric-min.js';
        static::$js_files[] = 'assets/js/product.js';

        $title_view = 'Thêm sản phẩm mới';
        if(!empty($id)){
            $title_view = 'Sửa sản phẩm';
        }                

        // get data inital
        $lazada_info = true;

        $http = new Client();
        $extra_url = !empty($id) ? '/' . $id : '';
        $params_url = '';
        if($lazada_info){
            $params_url = '?lazada_info=1';
        }
        $response = $http->get(API_DOMAIN_URL . 'product/inital-data-form' . $extra_url . $params_url);
        $result = $response->getJson();
        $data = !empty($result[DATA]) ? $result[DATA] : [];
        $list_status = $product = $lazada_list_attributes = $lazada_normal_attributes = $lazada_sku_attributes = [];
        if(!empty($data)){
            $list_status = !empty($data['list_status']) ? $data['list_status'] : [];
            $product = !empty($data['product']) ? $data['product'] : [];
            $lazada_list_attributes = !empty($data['lazada_list_attributes']) ? $data['lazada_list_attributes'] : [];
        }

        if(!empty($lazada_list_attributes)){
            foreach($lazada_list_attributes as $attribute){
                switch($attribute['attribute_type']){
                    case 'normal':
                        $lazada_normal_attributes[] = $attribute;
                        break;
                    case 'sku':
                        $lazada_sku_attributes[] = $attribute;
                        break;                    
                }
                
            }
        }

        // debug($product);
        // exit;

        $this->set('list_status', $list_status);
        $this->set('product', $product);
        $this->set('lazada_normal_attributes', $lazada_normal_attributes);
        $this->set('lazada_sku_attributes', $lazada_sku_attributes);
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
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
