<?php

use Cake\Http\Middleware\CsrfProtectionMiddleware;
use Cake\Routing\RouteBuilder;
use Cake\Routing\Router;
use Cake\Routing\Route\DashedRoute;

/**
 * The default class to use for all routes
 *
 * The following route classes are supplied with CakePHP and are appropriate
 * to set as the default:
 *
 * - Route
 * - InflectedRoute
 * - DashedRoute
 *
 * If no call is made to `Router::defaultRouteClass()`, the class used is
 * `Route` (`Cake\Routing\Route\Route`)
 *
 * Note that `Route` does not do any inflections on URLs which will result in
 * inconsistently cased URLs when used with `:plugin`, `:controller` and
 * `:action` markers.
 *
 * Cache: Routes are cached to improve performance, check the RoutingMiddleware
 * constructor in your `src/Application.php` file to change this behavior.
 *
 */
Router::defaultRouteClass(DashedRoute::class);

Router::scope('/', function (RouteBuilder $routes) {
    // Register scoped middleware for in scopes.
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
        '/product/item/add', ['controller' => 'Product', 'action' => 'ajaxAddItem']
    );

    $routes->connect(
        '/product/item/sku-attributes/load', ['controller' => 'Product', 'action' => 'ajaxLoadLazadaSkuAttributes']
    );

    // lazada
    $routes->connect(
        '/lazada/category/get-list-lazada-categories', ['controller' => 'LazadaCategory', 'action' => 'getListLazadaCategory']
    );












    /**
     * Connect catchall routes for all controllers.
     *
     * Using the argument `DashedRoute`, the `fallbacks` method is a shortcut for
     *
     * ```
     * $routes->connect('/:controller', ['action' => 'index'], ['routeClass' => 'DashedRoute']);
     * $routes->connect('/:controller/:action/*', [], ['routeClass' => 'DashedRoute']);
     * ```
     *
     * Any route class can be used with this method, such as:
     * - DashedRoute
     * - InflectedRoute
     * - Route
     * - Or your own route class
     *
     * You can remove these routes once you've connected the
     * routes you want in your application.
     */
    $routes->fallbacks(DashedRoute::class);
});

/**
 * If you need a different set of middleware or none at all,
 * open new scope and define routes there.
 *
 * ```
 * Router::scope('/api', function (RouteBuilder $routes) {
 *     // No $routes->applyMiddleware() here.
 *     // Connect API actions here.
 * });
 * ```
 */
