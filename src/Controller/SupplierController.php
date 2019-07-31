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

    public function quickAddSupplier(){
        $this->layout = false;

        // get data
        $http = new Client();
        $response = $http->get(API_DOMAIN_URL . 'supplier/inital-data-form-quick-add-supplier');  
        $result = $response->json;
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $cities_districts = !empty($data['cities_districts']) ? $data['cities_districts'] : [];

        $this->set('cities_districts', $cities_districts);
        $this->render('quick_add_supplier');
    }

























}
