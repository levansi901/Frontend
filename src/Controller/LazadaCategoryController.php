<?php

namespace App\Controller;
use Cake\Http\Client;

class LazadaCategoryController extends AppController
{

    public function initialize() {

    }

    public function getListLazadaCategory() {
        $data = $this->request->data;
        $list_category_ids = !empty($data['list_category_ids']) ? $data['list_category_ids'] : [];        
        $categories = [];
        if ($this->request->is('post') && !empty($list_category_ids)) {

            $http = new Client();
            $response = $http->get(API_DOMAIN_URL . 'lazada/category/get-by-tree-ids?tree_ids=' . implode(',', $list_category_ids));  
            $result = $response->getJson();
            $categories = !empty($result['data']) ? $result['data'] : [];
        }       

        $this->response->type('json');
        $this->response->body(json_encode($categories));
        return $this->response;

    }












}
