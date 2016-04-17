package ;

import luxe.Input;
import phoenix.BitmapFont;
import phoenix.Texture;
import snow.types.Types.AudioHandle;
import luxe.resource.Resource;
import luxe.Parcel;
import luxe.ParcelProgress;


class Main extends luxe.Game {

    var music : AudioResource;
    var musicHandle : AudioHandle;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {
        org.gesluxe.Gesluxe.init();

		var parcel = new Parcel({
			textures : [
				{ id:'assets/Triangle.png' },
				{ id:'assets/Square.png' }
			],
			// fonts : [{ id : 'assets/montez/montez.fnt' }],
			sounds : [
				{ id : "assets/ShapeShiftTheme.wav", is_stream : false }
			]
		});

		  //and a simpe progress bar
		new ParcelProgress({
			parcel      : parcel,
			background  : new luxe.Color(0.5, 0.89, 0.31, 0.75),
			oncomplete  : assets_loaded
		});

		  //go!
		parcel.load();


    } //ready

	function assets_loaded(_) {
		music = Luxe.resources.audio("assets/ShapeShiftTheme.wav");
		musicHandle = Luxe.audio.loop(music.source);
		new Board();
	}


    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main
