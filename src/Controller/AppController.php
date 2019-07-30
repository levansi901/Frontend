<?php

namespace App\Controller;

use Cake\Controller\Controller;
use Cake\Event\Event;
use Cake\Core\Configure;
use View\SmartyView;

class AppController extends Controller
{
    public static $css_layout = [
        'assets/plugins/materialize/css/materialize.css',
        'assets/plugins/material-preloader/css/materialPreloader.css',
        'assets/plugins/sweetalert/sweetalert.css',
        'assets/css/alpha.css',
        'assets/css/custom.css'
    ];

    public static $js_layout = [
        'assets/plugins/jquery/jquery-2.2.0.min.js',
        'assets/plugins/materialize/js/materialize.js',
        'assets/plugins/material-preloader/js/materialPreloader.js',
        'assets/plugins/jquery-blockui/jquery.blockui.js',
        'assets/plugins/sweetalert/sweetalert.min.js',
        'assets/plugins/auto-numeric/auto-numeric.min.js',
        'assets/js/alpha.js',
        'assets/js/page.js'
    ];

    public static $css_files = [];
    public static $js_files = [];    

    public function initialize()
    {
        parent::initialize();
        $this->loadComponent(
            'RequestHandler', ['enableBeforeRedirect' => false]
        );
        
        //$this->loadComponent('Flash');
        //$this->loadComponent('Security');

        $this->set('title_for_layout', 'Sale Support');
    }

    public function beforeRender(Event $event){

        if (!$this->request->is('ajax')) {
            $css_layout = array_merge(static::$css_layout, static::$css_files);
            $js_layout = array_merge(static::$js_layout, static::$js_files);

            $css_layout = array_unique($css_layout);
            $css_layout = array_chunk($css_layout, 10);

            $js_layout = array_unique($js_layout);
            $js_layout = array_chunk($js_layout, 10);

            $this->set('css_layout', $css_layout);
            $this->set('js_layout', $js_layout);
        }

        // set view smarty
        $this->viewBuilder()->setClassName('Smarty');
    }
}
