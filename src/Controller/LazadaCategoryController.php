<?php

namespace App\Controller;
use Cake\Network\Http\Client;

class LazadaCategoryController extends AppController
{

    public function initialize() {

    }

    public function getListLazadaCategory() {
        $this->layout = false;
        $this->autoRender = false;
        $data = $this->request->data;
        $list_category_ids = !empty($data['list_category_ids']) ? $data['list_category_ids'] : [];       
        $categories = [];
        if ($this->request->is('post') && (!empty($list_category_ids) || !empty($parent_id))) {
            $http = new Client();
            $response = $http->get(API_DOMAIN_URL . '/lazada/category/get-by-tree-ids?tree_ids=' . implode(',', $list_category_ids));  
            $result = $response->json;
            $categories = !empty($result['data']) ? $result['data'] : [];
        }       

        return json_encode($categories);
    }












}
