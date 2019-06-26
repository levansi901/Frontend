<?php

namespace App\Controller;
use Cake\Http\Client;

class LazadaBrandController extends AppController
{

    public function initialize() {

    }

    public function getLazadaBrand() {
        $data_post = $this->request->data;
        $keyword = !empty(trim($data_post['keyword'])) ? trim($data_post['keyword']) : '';
        $data = [];
        if ($this->request->is('post') && !empty($keyword)) {
            $http = new Client();       
            $url_api = API_DOMAIN_URL . 'lazada/brand/get?name=' . $keyword;
            $response = $http->get($url_api);  
            $result = $response->getJson();
            $data = !empty($result[DATA]['list']) ? $result[DATA]['list'] : [];
        }

        $this->response->type('json');
        $this->response->body(json_encode($data));
        return $this->response;
    }



}
