<?php

namespace App\Controller;
use Cake\Core\Configure;
use Cake\Http\Client;


class InventoryController extends AppController
{

    public function initialize() {
        parent::initialize();
        $this->set('title_for_layout', 'Phiếu xuất nhập kho');
    }

    public function index(){
        static::$css_layout[] = 'assets/plugins/air-datepicker/css/datepicker.css';
        static::$css_layout[] = 'assets/plugins/auto-complete/jquery.auto-complete.css';
                        
        static::$js_files[] = 'assets/plugins/air-datepicker/js/datepicker.js';        
        static::$js_files[] = 'assets/plugins/auto-numeric/auto-numeric.min.js';
        static::$js_files[] = 'assets/plugins/auto-complete/jquery.auto-complete.min.js';
        static::$js_files[] = 'assets/js/bill_list.js';

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'bill/inital-data-form-list');  
        $result = $response->json;
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $list_shops = $bills = $pagination = [];

        if(!empty($data)){
            $list_shops = !empty($data['list_shops']) ? $data['list_shops'] : [];  
        	$bills = !empty($data['bills'][DATA]) ? $data['bills'][DATA] : [];
            $pagination = !empty($data['products'][PAGINATION]) ? $data['products'][PAGINATION] : [];
        } 

        $this->set('list_shops', $list_shops);
        $this->set('bills', $bills);
        $this->set('pagination', $pagination);
        
        $this->set('limit_pagination', Configure::read('LIMIT_PAGINATION'));
        $this->set('list_type_bill', Configure::read('TYPE_BILL'));
        $this->set('list_type_receipt', Configure::read('TYPE_RECEIPT'));
        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', 'Phiếu xuất/nhập kho');
    }

    public function listBill(){
        $this->layout = false;

        $params = [
            'code' => '',
            'product_filter' => '',
            'type' => '',
            'type_receipt' => '',
            'shop_id' => '',
            'supplier_id' => '',
            'check_inventory_id' => '',
            'return_bill_id' => '',
            'ecommerce_partner' => '',
            'staff_id' => '',
            'created_by' => '',
            'note' => '',
            'create_from' => '',
            'create_to' => '',
            'total_from' => '',
            'total_to' => '',
            'page' => 1,
            'sort' => '',
            'direction' => '',
            'format' => '',
            'limit' => PAGE_DEFAULT
        ];

        if (!$this->request->is('ajax')) {
            return $this->redirect('/inventory/bill');            
        }   	        

        // mere data port from view
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        if ($this->request->is('post') && !empty($data_post)) {
            $params = array_merge($params, $data_post);
        }

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'bill/list?' . http_build_query(array_filter($params, 'strlen')));  
        $result = $response->json;
        $bills = !empty($result[DATA]) ? $result[DATA] : [];
        $pagination = !empty($result[PAGINATION]) ? $result[PAGINATION] : [];
        
        $this->set('params', $params);
        $this->set('bills', $bills);
        $this->set('pagination', $pagination);
        $this->set('limit_pagination', Configure::read('LIMIT_PAGINATION'));
        $this->set('list_type_receipt', Configure::read('TYPE_RECEIPT'));
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

        $result = [
            STATUS => STATUS_ERROR,
            MESSAGE => ''
        ];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        if (!$this->request->is('post') || empty($data_post)) {
            $result[MESSAGE] = 'Dữ liệu không hợp lệ';
            return $this->responseJson($result);
        }
        
        $data_post['id'] = $id;

        // parse data items
        $items = !empty($data_post['data_items']) ? json_decode($data_post['data_items'], true) : [];
        if(empty($items)){
            $result[MESSAGE] = 'Không lấy được thông tin sản phẩm';
            return $this->responseJson($result);
        }
        $data_post['items'] = $items;
        unset($data_post['data_items']);
        
        $http = new Client();
        $response = $http->post(API_DOMAIN_URL . 'bill/save', json_encode($data_post), ['type' => 'json']);      
        $result = $response->getJson();
        $data = !empty($result[DATA]) ? $result[DATA] : [];        
        return $this->responseJson($result);
    }

    public function detailBill($id = null){
        if(empty($id)){
            return $this->redirect('/404');
        }

        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'bill/detail/' . $id);
        $result = $response->getJson();
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $bill = !empty($data['bill']) ? $data['bill'] : [];
        $contact = !empty($data['contact']) ? $data['contact'] : [];
        $supplier = !empty($data['supplier']) ? $data['supplier'] : [];
        $items = !empty($data['items']) ? $data['items'] : [];

        $this->set('bill', $bill);
        $this->set('contact', $contact);
        $this->set('supplier', $supplier);
        $this->set('items', $items);

        $this->set('list_type_bill', Configure::read('TYPE_BILL'));
        $this->set('list_type_receipt', Configure::read('TYPE_RECEIPT'));

        $this->set('csrf_token', $this->request->getParam('_csrfToken'));
        $this->set('title_for_layout', 'Chi tiết phiếu');
        $this->set('url_reference', '/inventory/bill');
        $this->render('detail');
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
        static::$css_layout[] = 'assets/plugins/popover/jquery.webui-popover.css';

        static::$js_files[] = 'assets/plugins/select2/js/select2.full.js';
        static::$js_files[] = 'assets/plugins/auto-complete/jquery.auto-complete.min.js';
        static::$js_files[] = 'assets/plugins/popover/jquery.webui-popover.js';        
        static::$js_files[] = 'assets/js/bill.js';
        static::$js_files[] = 'assets/js/bill_add_supplier.js';

        $list_shop = [];
        
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
