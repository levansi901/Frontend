<?php

namespace App\Controller;

use Cake\Controller\Controller;
use Cake\Event\Event;

use View\SmartyView;

class AppController extends Controller
{


    public function beforeRender(Event $event){
        $this->viewBuilder()->setClassName('Smarty'); // SET SMARTY VIEW
    }

    public function initialize()
    {
        parent::initialize();

        $this->loadComponent('RequestHandler', [
            'enableBeforeRedirect' => false,
        ]);
        
        // $this->loadComponent('Flash');
        //$this->loadComponent('Security');
    }
}
