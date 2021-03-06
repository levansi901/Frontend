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
        '/product/edit/:id', ['controller' => 'Product', 'action' => 'saveProduct'], ['pass' => ['id'], 'id' => '[0-9]+']
    );

    $routes->connect(
        '/product/save', ['controller' => 'Product', 'action' => 'ajaxSaveProduct']
    );

    $routes->connect(
        '/product/save/:id', ['controller' => 'Product', 'action' => 'ajaxSaveProduct'], ['pass' => ['id'], 'id' => '[0-9]+']
    );

    $routes->connect(
        '/product/delete', ['controller' => 'Product', 'action' => 'deleteProduct']
    );

    $routes->connect(
        '/product/delete/image', ['controller' => 'Product', 'action' => 'deleteProductImage']
    );

    $routes->connect(
        '/product/change-status', ['controller' => 'Product', 'action' => 'changeStatusProduct']
    );

    $routes->connect(
        '/product/item/get', ['controller' => 'Product', 'action' => 'getProductItem']
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

    // inventory
    $routes->connect(
        '/inventory', ['controller' => 'Inventory', 'action' => 'index']
    );

    $routes->connect(
        '/inventory/bill', ['controller' => 'Inventory', 'action' => 'index']
    );

    $routes->connect(
        '/inventory/bill/index', ['controller' => 'Inventory', 'action' => 'index']
    );

    $routes->connect(
        '/inventory/bill/list', ['controller' => 'Inventory', 'action' => 'listBill']
    );

    $routes->connect(
        '/inventory/detail/:id', ['controller' => 'Inventory', 'action' => 'detailBill'], ['pass' => ['id'], 'id' => '[0-9]+']
    );

    // $routes->connect(
    //     '/inventory/edit/:id', ['controller' => 'Inventory', 'action' => 'saveBill'], ['pass' => ['id'], 'id' => '[0-9]+']
    // );

    $routes->connect(
        '/inventory/save', ['controller' => 'Inventory', 'action' => 'ajaxSaveBill']
    );

    $routes->connect(
        '/inventory/add-supplier', ['controller' => 'Inventory', 'action' => 'addSupplier']
    );

    $routes->connect(
        '/inventory/transfer', ['controller' => 'Inventory', 'action' => 'addTransfer']
    );

    $routes->connect(
        '/inventory/another', ['controller' => 'Inventory', 'action' => 'addAnother']
    );

    $routes->connect(
        '/inventory/check', ['controller' => 'Inventory', 'action' => 'addCheck']
    );

    // supplier
    $routes->connect(
        '/supplier/view-quick-add-supplier', ['controller' => 'Supplier', 'action' => 'viewQuickAddSupplier']
    );

    $routes->connect(
        '/supplier/quick-add-supplier', ['controller' => 'Supplier', 'action' => 'ajaxQuickAddSupplier']
    );

    $routes->connect(
        '/supplier/get/ajax', ['controller' => 'Supplier', 'action' => 'ajaxGetSupplier']
    );

    // user
    $routes->connect(
        '/user/get/ajax', ['controller' => 'User', 'action' => 'ajaxGetUser']
    );

    $routes->fallbacks(DashedRoute::class);
});
