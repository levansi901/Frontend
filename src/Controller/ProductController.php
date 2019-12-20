<?php

namespace App\Controller;
use Cake\Core\Configure;
use Cake\Http\Client;


class ProductController extends AppController {

    public function initialize() {
        parent::initialize();
        $this->set('title_for_layout', 'Sản phẩm');
    }

    public function index(){
        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';
        static::$js_files[] = 'assets/plugins/auto-numeric/auto-numeric.min.js';
        static::$js_files[] = 'assets/js/product_list.js';    

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'product/inital-data-form-list');  
        $result = $response->json;
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $list_status = $list_shops = $list_brands = $list_categories = $list_has_inventory = $list_has_image = $products = $pagination = [];

        if(!empty($data)){
        	$list_status = !empty($data['list_status']) ? $data['list_status'] : [];
            $list_shops = !empty($data['list_shops']) ? $data['list_shops'] : [];
            $list_has_inventory = !empty($data['list_has_inventory']) ? $data['list_has_inventory'] : [];
            $list_has_image = !empty($data['list_has_image']) ? $data['list_has_image'] : [];       
        	$products = !empty($data['products'][DATA]) ? $data['products'][DATA] : [];
            $pagination = !empty($data['products'][PAGINATION]) ? $data['products'][PAGINATION] : [];
        }
        
        $this->set('list_status', $list_status);
        $this->set('list_shops', $list_shops);
        $this->set('list_has_inventory', $list_has_inventory);
        $this->set('list_has_image', $list_has_image);
        $this->set('products', $products);
        $this->set('pagination', $pagination);
        $this->set('limit_pagination', Configure::read('LIMIT_PAGINATION'));
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', 'Sản phẩm');
        
    }

    public function listProduct(){
        $this->layout = false;

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
            'sort' => '',
            'direction' => '',
            'format' => '',
            'lang' => '',
            'limit' => PAGE_DEFAULT            
        );

        if (!$this->request->is('ajax')) {
            return $this->redirect('/product');            
        }   	        

        // mere data port from view
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        if ($this->request->is('post') && !empty($data_post)) {
            $params = array_merge($params, $data_post);
        }

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'product/list?' . http_build_query(array_filter($params)));  
        $result = $response->json;
        $products = !empty($result[DATA]) ? $result[DATA] : [];
        $pagination = !empty($result[PAGINATION]) ? $result[PAGINATION] : [];
        
        $this->set('params', $params);
        $this->set('products', $products);
        $this->set('pagination', $pagination);
        $this->set('limit_pagination', Configure::read('LIMIT_PAGINATION'));
        $this->render('list');
    }

    public function saveProduct($id = null){

        static::$css_layout[] = 'assets/plugins/fancybox/jquery.fancybox.css';
        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        static::$css_layout[] = 'assets/plugins/auto-complete/jquery.auto-complete.css';

        static::$js_files[] = 'assets/plugins/tinymce/tinymce.min.js';
        static::$js_files[] = 'assets/plugins/fancybox/jquery.fancybox.js';
        static::$js_files[] = 'assets/plugins/jquery-validation/jquery.validate.min.js';
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';
        static::$js_files[] = 'assets/plugins/auto-numeric/auto-numeric.min.js';
        static::$js_files[] = 'assets/plugins/auto-complete/jquery.auto-complete.min.js';
        static::$js_files[] = 'assets/js/product.js';        

        $title_for_layout = 'Thêm sản phẩm';
        if(!empty($id)){
            $title_for_layout = 'Xem thông tin sản phẩm';
        }                

        $customer_id = 1;
        $filemanager_access_key = base64_encode($customer_id . '|' . ACCESS_KEY_UPLOAD);

        // get data inital
        $lazada_info = true;        
        $extra_url = !empty($id) ? '/' . $id : '';
        $params_url = '';
        if($lazada_info){
            $params_url = '?lazada_info=1';
        }

        $http = new Client();
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
                        if(!empty($attribute['is_mandatory'])){
                            $lazada_sku_attributes[] = $attribute;    
                        }                        
                        break;                    
                }
                
            }
        }        
        
        $this->set('list_status', $list_status);
        $this->set('product', $product);
        $this->set('lazada_normal_attributes', $lazada_normal_attributes);
        $this->set('lazada_sku_attributes', $lazada_sku_attributes);
        $this->set('filemanager_access_key', $filemanager_access_key);
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', $title_for_layout);
        $this->set('url_reference', '/product/add');
        $this->render('save');
    }

    public function ajaxSaveProduct($id = null){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        
        if ($this->request->is('post') && !empty($data_post)) {
            $data_post['id'] = $id;
            $http = new Client();
            $response = $http->post(API_DOMAIN_URL . 'product/save', json_encode($data_post), ['type' => 'json']);      
            $result = $response->getJson();
            $data = !empty($result[DATA]) ? $result[DATA] : [];
        }
        $this->response->type('json');
        $this->response->body(json_encode($result));
        return $this->response;
    }

    public function ajaxLoadLazadaAttributes(){
        $this->layout = false;
        $data_post = !empty($this->request->data) ? $this->request->data : [];

        $lazada_category_id = !empty($data_post['lazada_category_id']) ? intval($data_post['lazada_category_id']) : null;    
        $type = !empty($data_post['type']) ? $data_post['type'] : null;   
        $lazada_attributes = [];
        if($this->request->is('ajax') && !empty($lazada_category_id) && !empty($type)){ 
            $lazada_list_attributes = $this->getListLazadaAttributes($lazada_category_id);
            if(!empty($lazada_list_attributes)){
                foreach ($lazada_list_attributes as $k => $attribute) {
                    if($type == 'sku' && $attribute['attribute_type'] == 'sku' && !empty($attribute['is_mandatory'])){
                        $lazada_attributes[] = $attribute;
                    }

                    if($type == 'spu' && $attribute['attribute_type'] == 'normal'){
                        $lazada_attributes[] = $attribute;
                    }                    
                }
            }
        }
        $this->set('lazada_attributes', $lazada_attributes);
        $this->render('lazada_attributes');
    }

    private function getListLazadaAttributes($lazada_category_id = null) {
        $result = [];
        if(!empty($lazada_category_id)){        
            $http = new Client(); 
            $response = $http->get(API_DOMAIN_URL . 'lazada/category/attributes/get?lazada_category_id=' . $lazada_category_id);
            $result = $response->getJson();
            $result = !empty($result[DATA]) ? $result[DATA] : [];                        
        }
        return $result;
    }

    public function deleteProduct(){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        $ids = !empty($data_post['ids']) ? $data_post['ids'] : [];
        if ($this->request->is('post') && !empty($ids)) {      
            $http = new Client();
            $response = $http->post(API_DOMAIN_URL . 'product/delete', json_encode(['ids' => $ids]), ['type' => 'json']);      
            $result = $response->getJson();
            $data = !empty($result[DATA]) ? $result[DATA] : [];
        }
        $this->response->type('json');
        $this->response->body(json_encode($result));
        return $this->response;
    }

    public function changeStatusProduct(){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        $ids = !empty($data_post['ids']) ? $data_post['ids'] : [];
        $status = isset($data_post['status']) ? intval($data_post['status']) : 1;

        if ($this->request->is('post') && !empty($ids)) {      
            $http = new Client();
            $response = $http->post(API_DOMAIN_URL . 'product/change-status', json_encode(['ids' => $ids, 'status' => $status]), ['type' => 'json']);      
            $result = $response->getJson();
            $data = !empty($result[DATA]) ? $result[DATA] : [];
        }
        $this->response->type('json');
        $this->response->body(json_encode($result));
        return $this->response;
    }

    public function getProductItem(){
        $data_post = $this->request->data;
        $data = [];
        if ($this->request->is('post') && !empty($data_post)) {
            $http = new Client();       
            $url_api = API_DOMAIN_URL . 'product/item/get?' . http_build_query(array_filter($data_post));
            $response = $http->get($url_api);              
            $result = $response->getJson();
            $data = !empty($result[DATA]) ? $result[DATA] : [];
        }

        $this->response->type('json');
        $this->response->body(json_encode($data));
        return $this->response;
    }
































}
