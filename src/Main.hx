
import luxe.Input;

class Main extends luxe.Game {

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({ id:'assets/Triangle.png' });

        return config;

    } //config

    override function ready() {
        new Board();
    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main