import Main;

import luxe.Core;
import luxe.AppConfig;

import snow.Snow;
import snow.types.Types;

class LuxeApp {

    public static var _game : Main;
    public static var _snow : Snow;
    public static var _conf : luxe.AppConfig;

    public static function main () {

        //Start with sane defaults

        _conf = {
            headless: false,
            window: {
                width: 960,
                height: 640,
                fullscreen: false,
                resizable: true,
                borderless: false,
                title: 'luxe app'
            }
        } //_conf

        #if mobile
            _conf.window.fullscreen = true;
            _conf.window.borderless = true;
        #end //mobile

        
        //Apply the values if they are set
            _conf.window.width = 960;
            _conf.window.height = 640;
            _conf.window.fullscreen = false;
            _conf.window.resizable = true;
            _conf.window.borderless = false;
            _conf.window.title = '◯ Shape Snap ◯';

            //Create the app class, give it to the bootstrapper
        _game = new Main();
            //Create the snow + luxe runtime
        _snow = new Snow(new Core(_game, _conf));

    } //main

} //LuxeApp