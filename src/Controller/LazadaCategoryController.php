<?php

namespace App\Controller;
use Cake\Http\Client;

class LazadaCategoryController extends AppController
{

    public function initialize() {

    }

    public function getListLazadaCategory() {
        $data = $this->request->data;
        $tree_category_id = !empty($data['tree_category_id']) ? $data['tree_category_id'] : [];
        $parent_id = isset($data['parent_id']) ? intval($data['parent_id']) : null;        
        $categories = [];
        if ($this->request->is('post') && (!empty($tree_category_id) || !is_null($parent_id))) {
            $http = new Client();    

            $get_by_parent = true;        
            $url_api = API_DOMAIN_URL . 'lazada/category/get-by-parent?parent_id=' . $parent_id;        
            if(!empty($tree_category_id)){
                $get_by_parent = false;
                $url_api = API_DOMAIN_URL . 'lazada/category/get-by-tree-ids?tree_ids=' . implode(',', $tree_category_id);                
            }

            $response = $http->get($url_api);  
            $result = $response->getJson();
            $categories = !empty($result[DATA]) ? $result[DATA] : [];
            if($get_by_parent && !empty($categories)){
                $categories = [0 => $categories];
            }
        }       

        $this->response->type('json');
        $this->response->body(json_encode($categories));
        return $this->response;

    }












}
