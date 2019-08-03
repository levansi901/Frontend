<?php

namespace App\Controller;
use Cake\Core\Configure;
use Cake\Http\Client;


class SupplierController extends AppController
{

    public function initialize() {
        parent::initialize();
        $this->set('title_for_layout', 'Nhà cung cấp');
    }

    public function listSupplier(){

    }

    public function viewQuickAddSupplier(){
        $this->layout = false;

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'supplier/inital-data-form-quick-add-supplier');  
        $result = $response->json;
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $cities_districts = !empty($data['cities_districts']) ? $data['cities_districts'] : [];
        $groups = !empty($data['groups']) ? $data['groups'] : [];

        $this->set('cities_districts', $cities_districts);
        $this->set('groups', $groups);
        $this->render('quick_add_supplier');
    }

    public function ajaxQuickAddSupplier(){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        if ($this->request->is('post') && !empty($data_post)) {
            $http = new Client();
            $response = $http->post(API_DOMAIN_URL . 'supplier/save', json_encode($data_post), ['type' => 'json']);
            $result = !empty($response->getJson()) ? $response->getJson() : [];
        }

        $this->response->type('json');
        $this->response->body(json_encode($result));
        return $this->response;
    }

    public function ajaxGetSupplier(){
        $this->layout = false;
        $this->autoRender = false;

        $result = [];
        $data_post = !empty($this->request->data) ? $this->request->data : [];
        if (!$this->request->is('post') || empty($data_post['keyword'])) {
            $result = [
                MESSAGE => 'Dữ liệu không hợp lệ'
            ];
        }

        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'supplier/list?'. http_build_query(array_filter($data_post)));    
        $result = $response->getJson();
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $this->response->type('json');
        $this->response->body(json_encode($data));
    }





















}
