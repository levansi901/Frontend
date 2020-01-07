<?php

namespace App\Controller;
use Cake\Core\Configure;
use Cake\Http\Client;


class UserController extends AppController
{

    public function initialize() {
        parent::initialize();
        $this->set('title_for_layout', 'Tài khoản');
    }

    public function listUser(){

    }

    public function ajaxGetUser(){
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
        $response = $http->get(API_DOMAIN_URL . 'user/list?'. http_build_query(array_filter($data_post, 'strlen')));    
        $result = $response->getJson();
        $data = !empty($result[DATA]) ? $result[DATA] : [];

        $this->response->type('json');
        $this->response->body(json_encode($data));
    }





















}
