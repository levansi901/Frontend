<?php

use Cake\Http\Middleware\CsrfProtectionMiddleware;
use Cake\Routing\RouteBuilder;
use Cake\Routing\Router;
use Cake\Routing\Route\DashedRoute;


Router::defaultRouteClass(DashedRoute::class);
Router::scope('/', function (RouteBuilder $routes) {
    $routes->registerMiddleware('csrf', new CsrfProtectionMiddleware([
        'httpOnly' => true
    ]));
    $routes->applyMiddleware('csrf');


    //dashboard
    $routes->connect(
        '/', ['controller' => 'Dashboard', 'action' => 'index']
    );

    // product
    $routes->connect(
        '/product', ['controller' => 'Product', 'action' => 'index']
    );

    $routes->connect(
        '/product/index', ['controller' => 'Product', 'action' => 'index']
    );

    $routes->connect(
        '/product/list', ['controller' => 'Product', 'action' => 'listProduct']
    );

    $routes->connect(
        '/product/add', ['controller' => 'Product', 'action' => 'saveProduct']
    );

    $routes->connect(
        '/product/edit/:id', ['controller' => 'Product', 'action' => 'saveProduct'], ['pass' => array('id'), "id" => "[0-9]+"]
    );

    $routes->connect(
        '/product/save', ['controller' => 'Product', 'action' => 'ajaxSaveProduct']
    );

    $routes->connect(
        '/product/save/:id', ['controller' => 'Product', 'action' => 'ajaxSaveProduct'], ['pass' => array('id'), "id" => "[0-9]+"]
    );

    $routes->connect(
        '/product/delete', ['controller' => 'Product', 'action' => 'ajaxDeleteProduct']
    );

    $routes->connect(
        '/product/item/add', ['controller' => 'Product', 'action' => 'ajaxAddItem']
    );

    $routes->connect(
        '/product/lazada/load-attributes', ['controller' => 'Product', 'action' => 'ajaxLoadLazadaAttributes']
    );

    // lazada
    $routes->connect(
        '/lazada/category/get', ['controller' => 'LazadaCategory', 'action' => 'getListLazadaCategory']
    );

    $routes->connect(
        '/lazada/brand/get', ['controller' => 'LazadaBrand', 'action' => 'getLazadaBrand']
    );

    $routes->fallbacks(DashedRoute::class);
});
