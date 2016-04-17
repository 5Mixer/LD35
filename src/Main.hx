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

    var sec = 0;

    override function config(config:luxe.AppConfig) {
        config.render.antialiasing = 4;

        return config;

    } //config

    override function ready() {
        org.gesluxe.Gesluxe.init();

		var parcel = new Parcel({
			textures : [
				{ id:'assets/Triangle.png' },
				{ id:'assets/Wood.jpg' },
				{ id:'assets/Board.png' },
				{ id:'assets/Square.png' },
				{ id:'assets/Circle.png' }
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
	var timerText : luxe.Text;

    var bg:luxe.Sprite;

    var gradients = [
        {a:0x546262,b:0x182848},
        {a:0x546262,b:0x0ABFBC},
        {a:0x546262,b:0x480048},
        {a:0x546262,b:0x49a09d},
        {a:0x546262,b:0x71B280},
    ];
    var grad:Gradient;

    var board:Board;

	function assets_loaded(_) {
		music = Luxe.resources.audio("assets/ShapeShiftTheme.wav");
		musicHandle = Luxe.audio.loop(music.source);

        //scale to fit the screen nicely, but max at the font default size of 48,
		//and the 12 is a ratio I made up based on the default window size
		var text_size = Math.min( Math.round(Luxe.screen.h/12), 24);

		text = new luxe.Text({
			pos : new luxe.Vector(Luxe.screen.mid.x,100),
			point_size : text_size,
			depth : 3,
			align : TextAlign.center,
			font : Luxe.resources.font('assets/fonts/PaytoneOne.fnt'),
			text : 'Shiftrift',
			color : new luxe.Color(0.41, 0.69, 0.27)
		});

        timerText = new luxe.Text({
			pos : new luxe.Vector(Luxe.screen.mid.x,100),
			point_size : text_size,
			depth : 3,
			align : TextAlign.center,
			font : Luxe.resources.font('assets/fonts/PaytoneOne.fnt'),
			text : '',
            glow_color: new luxe.Color(0.28, 0.29, 0.27),
            glow_amount: 5.0,
			color : new luxe.Color(0.41, 0.69, 0.27)
		});

		board = new Board(Luxe.screen.size.x*(1/4),null,false);


        text.pos.y = board.pos.y /2 - text.size.y/2;
        timerText.pos.y = Luxe.screen.size.y - 30 - text.size.y/2;

        var exampleBoard = new Board(Luxe.screen.size.x*(3/4),null,true);

        board.events.listen("EndLevel",function (level){
            exampleBoard.onLevelEnd();
            //sec = 0;
        });
        board.events.listen("Finished",function (_){

            text.text = "Woo! You actually finished! In "+sec+" seconds. Comment your score!";
            sec = 0;
            Luxe.timer.schedule( 5, function (){
                board.level = 0;
                board.onLevelStart();
            });
        });
        board.events.listen("NewLevel",function (level){
            text.text = Levels.levels[level].message;
            text.pos.y = board.pos.y /2 - text.size.y/2;
            gradienterise();
        });


		bg = new luxe.Sprite({
			size: Luxe.screen.size,
			origin: new luxe.Vector(0,0),
			depth: -50,
			color : new luxe.Color(0.34, 0.29, 0.32)
		});

        bg.add(grad = new Gradient(new luxe.Color().rgb(gradients[0].a),new luxe.Color().rgb(gradients[0].b)));

        text.text = Levels.levels[0].message;

        Luxe.timer.schedule( 1, tick);
        gradienterise();
	}

    function tick(){
        Luxe.timer.schedule( 1, tick);
        if (board.randomized == false) return;
        sec++;
        //FONT DOESNT INCLUDE NUMS :(
        timerText.text = '$sec seconds.';

        //trace(sec);


    }

    function gradienterise(){
        var index = Math.floor(Math.random()*gradients.length);
        luxe.tween.Actuate.tween( grad.colorA, 5, { r: new luxe.Color().rgb(gradients[index].a).r, g: new luxe.Color().rgb(gradients[index].a).g, b: new luxe.Color().rgb(gradients[index].a).b  });
        luxe.tween.Actuate.tween( grad.colorB, 5, { r: new luxe.Color().rgb(gradients[index].b).r, g: new luxe.Color().rgb(gradients[index].b).g, b: new luxe.Color().rgb(gradients[index].b).b  });

        Luxe.timer.schedule( 5, gradienterise);
    }


    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

        if(e.keycode == Key.enter) {
            board.onLevelEnd();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main
