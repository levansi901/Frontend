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
        '/product/delete', ['controller' => 'Product', 'action' => 'deleteProduct']
    );

    $routes->connect(
        '/product/change-status', ['controller' => 'Product', 'action' => 'changeStatusProduct']
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

    // order
    $routes->connect(
        '/order', ['controller' => 'Order', 'action' => 'index']
    );

    $routes->connect(
        '/order/index', ['controller' => 'Order', 'action' => 'index']
    );

    // bill
    $routes->connect(
        '/inventory/bill', ['controller' => 'Bill', 'action' => 'index']
    );

    $routes->connect(
        '/inventory/bill/index', ['controller' => 'Bill', 'action' => 'index']
    );

    $routes->connect(
        '/inventory/bill/list', ['controller' => 'Bill', 'action' => 'listBill']
    );

    $routes->connect(
        '/inventory/save', ['controller' => 'Bill', 'action' => 'ajaxSaveBill']
    );

    $routes->connect(
        '/inventory/save/:id', ['controller' => 'Bill', 'action' => 'ajaxSaveBill'], ['pass' => array('id'), "id" => "[0-9]+"]
    );

    $routes->connect(
        '/inventory/edit/:id', ['controller' => 'Bill', 'action' => 'saveBill'], ['pass' => array('id'), "id" => "[0-9]+"]
    );

    $routes->connect(
        '/inventory/add-supplier', ['controller' => 'Bill', 'action' => 'addSupplier']
    );

    $routes->connect(
        '/inventory/transfer', ['controller' => 'Bill', 'action' => 'addTransfer']
    );

    $routes->connect(
        '/inventory/another', ['controller' => 'Bill', 'action' => 'addAnother']
    );

    $routes->connect(
        '/inventory/check', ['controller' => 'Bill', 'action' => 'addCheck']
    );

    $routes->fallbacks(DashedRoute::class);
});
