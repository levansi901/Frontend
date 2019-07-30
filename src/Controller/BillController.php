<?php

namespace App\Controller;
use Cake\Core\Configure;
use Cake\Http\Client;


class BillController extends AppController
{

    public function initialize() {
        parent::initialize();
        $this->set('title_for_layout', 'Phiếu xuất nhập kho');
    }

    public function index(){
        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        
        
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';        
        static::$js_files[] = 'assets/plugins/auto-numeric/auto-numeric.min.js';
        static::$js_files[] = 'assets/js/bill_list.js';

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

    public function listBill(){
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

    public function saveBill($id = null){

        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        static::$css_layout[] = 'assets/plugins/auto-complete/jquery.auto-complete.css';

        static::$js_files[] = 'assets/plugins/tinymce/tinymce.min.js';
        static::$js_files[] = 'assets/plugins/jquery-validation/jquery.validate.min.js';
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';
        static::$js_files[] = 'assets/plugins/auto-numeric/auto-numeric.min.js';
        static::$js_files[] = 'assets/plugins/auto-complete/jquery.auto-complete.min.js';
        static::$js_files[] = 'assets/js/product.js';

        $title_for_layout = 'Thêm sản phẩm';
        if(!empty($id)){
            $title_for_layout = 'Xem thông tin sản phẩm';
        }                

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
        
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', $title_for_layout);
        $this->set('url_reference', '/product/add');
        $this->render('save');
    }

    public function ajaxSaveBill($id = null){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];

        if ($this->request->is('post') && !empty($data_post)) {
            $data_post['id'] = $id;
            $items = [];
            if(!empty($data_post['items'])){
                foreach ($data_post['items'] as $k => $item) {
                    
                }
            }

            $http = new Client();
            $response = $http->post(API_DOMAIN_URL . 'product/save', json_encode($data_post), ['type' => 'json']);      
            $result = $response->getJson();
            $data = !empty($result[DATA]) ? $result[DATA] : [];
        }
        $this->response->type('json');
        $this->response->body(json_encode($result));
        return $this->response;
    }

    public function deleteBill(){
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

    public function addSupplier(){
        static::$css_layout[] = 'assets/plugins/select2/css/select2.css';
        static::$css_layout[] = 'assets/plugins/auto-complete/jquery.auto-complete.css';
        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        static::$css_layout[] = 'assets/plugins/popover/jquery.webui-popover.css';

        static::$js_files[] = 'assets/plugins/select2/js/select2.full.js';
        static::$js_files[] = 'assets/plugins/auto-complete/jquery.auto-complete.min.js';
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';
        static::$js_files[] = 'assets/plugins/popover/jquery.webui-popover.js';        
        static::$js_files[] = 'assets/js/bill.js';
        static::$js_files[] = 'assets/js/bill_add_supplier.js';

        $list_shop = [];
        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'bill/inital-data-form');  
        $result = $response->json;
        $data = !empty($result[DATA]) ? $result[DATA] : [];
        if(!empty($data)){
            $list_shop = !empty($data['list_shop']) ? $data['list_shop'] : [];
        }

        $this->set('list_shop', $list_shop);
        $this->set('payment_method', Configure::read('PAYMENT_METHOD'));
        $this->set('type_discount', Configure::read('TYPE_DISCOUNT'));
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', 'Nhập hàng mới');
    }



















}
