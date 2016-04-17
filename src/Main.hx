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
				{ id:'assets/Wood.jpg' },
				{ id:'assets/Board.png' },
				{ id:'assets/Square.png' }
			],
			fonts : [
				{ id : 'assets/fonts/Arvo.fnt' },
				{ id : 'assets/fonts/PaytoneOne.fnt' }
			],
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

	//the text object
	var text : luxe.Text;
		//the font we will use

	function assets_loaded(_) {
		music = Luxe.resources.audio("assets/ShapeShiftTheme.wav");
		musicHandle = Luxe.audio.loop(music.source);
		new Board();

		//scale to fit the screen nicely, but max at the font default size of 48,
		//and the 12 is a ratio I made up based on the default window size
		var text_size = Math.min( Math.round(Luxe.screen.h/12), 48);

		//again, depth 3 > 2, so its above everything
		text = new luxe.Text({
			pos : new luxe.Vector(Luxe.screen.mid.x,100),
			point_size : text_size,
			depth : 3,
			align : TextAlign.center,
			font : Luxe.resources.font('assets/fonts/PaytoneOne.fnt'),
			text : 'Shiftrift',
			color : new luxe.Color(0.41, 0.69, 0.27)
		});

		var bg = new luxe.Sprite({
			size: Luxe.screen.size,
			origin: new luxe.Vector(0,0),
			depth: -50,
			color : new luxe.Color(0.34, 0.29, 0.32)
		});
	}


    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main
