package ;

import org.gesluxe.events.GestureEvent;
import org.gesluxe.gestures.SwipeGesture;

class Board extends luxe.Entity {

	public var tiles:Array<Tile>;

	public var tilesWide = 5;
	public var tilesHigh = 5;


	var width = 60;
	var height = 60;
	var padding = 10;

	public var level = 0;

	var controls:Bool;

	var bg:luxe.Sprite;

	var offsetx=0.0;
	var offsety=0.0;

	public var randomized = false;

	public function new (?offx,?offy,dummy=false) {

		if (offx == null){
			offx = Luxe.screen.size.x*.25;
		}
		if (offy == null){
			offy = Luxe.screen.mid.y;
		}

		offsetx = offx;
		offsety = offy;

		controls = !dummy;

		tilesWide = tilesHigh = Math.floor(Math.sqrt(Levels.levels[level].tiles.length));

		super({
			name:"Board",
			name_unique : true,
			pos: new luxe.Vector(Math.max(offx - (cast(tilesWide,Float)/2.0)*(width+padding),5), offy - (cast(tilesHigh,Float)/2.0)*(width+padding))
		});



		tiles = new Array<Tile>();

		bg = new luxe.Sprite({
			texture: Luxe.resources.texture("assets/Board.png"),
			pos: pos, origin: new luxe.Vector(0,0),
			size: new luxe.Vector(70*5+20+padding*2,70*5+20+padding*2),
			depth: -1
		});

		onLevelStart();

		debugTiles(tiles);

		if (controls){
			var swipe = new SwipeGesture();
			swipe.events.listen(GestureEvent.GESTURE_RECOGNIZED, onGesture);

		}


	}

	var randomMoves = 0;
	function randomMove(){
		randomMoves--;

		var col = Math.floor(Math.random() * tilesWide);
		var row = Math.floor(Math.random() * tilesHigh);
		var dir = Math.random() > 0.5;

		if (Math.random() > 0.5){
			shiftRow(row,dir);
		}else{
			shiftColumn(col,dir);
		}

		if (randomMoves > 0 || levelComplete(false)){
			Luxe.timer.schedule( 0.25, randomMove);
		}else{
			randomized = true;
		}
	}

	function randomize (moves){
		randomMoves = moves;
		randomMove();

	}

	function onGesture(event:GestureEventData)
	{
		var col = Math.floor((event.gesture.location.x-pos.x)/70);
		var row = Math.floor((event.gesture.location.y-pos.y)/70);

		var x = cast(event.gesture,SwipeGesture).offsetX > 0 ? true : false;
		var y = cast(event.gesture,SwipeGesture).offsetY > 0 ? true : false;

		if (getTile(col,row,false,true) == null) return;

		if (cast(event.gesture,SwipeGesture).offsetX == 0){
			trace('Swipe up/down! Column: ${col+1}, down:$y');
			shiftColumn(col,y);
		}else if (cast(event.gesture,SwipeGesture).offsetY == 0){
			trace('Swipe L/R! Row: ${row+1}, right:$x');
			shiftRow(row,x);
		}
	}

	function shiftRow(row:Int,right){

		var offset = (right) ? 1 : -1;

		for (x in 0...tilesWide){
			getTile(x,row,false,true).setPos(x+offset,row,true);
		}

		for (x in 0...tilesWide){
			getTile(x,row,false,false).showPos();
		}

		if (levelComplete()) onLevelEnd();
	}


	function shiftColumn (col:Int,down){

		var offset = (down) ? 1 : -1;

		for (y in 0...tilesHigh){
			getTile(col,y,false,true).setPos(col,y+offset,true);
		}

		for (y in 0...tilesHigh){
			getTile(col,y,false,false).showPos();
		}

		if (levelComplete()) onLevelEnd();
	}

	public function onLevelEnd (){
		level++;
		onLevelStart();
		events.fire("EndLevel",level);
		randomized = false;
	}
	public function onLevelStart () {


		if (level == Levels.levels.length){
			for (tile in tiles){
				tile.destroy();
			}
			tiles = null;
			events.fire("Finished",null);
			return;
		}

		events.fire("NewLevel",level);

		tilesWide = tilesHigh = Math.floor(Math.sqrt(Levels.levels[level].tiles.length));

		pos = new luxe.Vector(Math.max(offsetx - (cast(tilesWide,Float)/2)*(width+padding),5), offsety - (cast(tilesHigh,Float)/2)*(width+padding));

		for (tile in tiles){
			tile.destroy();
		}
		tiles = null;
		tiles = new Array<Tile>();

		for (x in 0...tilesWide){
			for (y in 0...tilesHigh){
				var tile:Tile = null;

				//if (Math.random() > .5){
				//	tile = new TriangleTile(x,y,this);
				//}else{
				//	tile = new SquareTile(x,y,this);
				//}
				var sym = Levels.levels[level].tiles[y*tilesWide+x];
				switch (sym){
					case "T" : tile = new TriangleTile(x,y,this);
					case "S" : tile = new SquareTile(x,y,this);
					case "C" : tile = new CircleTile(x,y,this);
				}


				tiles[y * tilesWide + x] = tile;
			}
		}

		bg.size = new luxe.Vector(tilesWide*(width+padding)+padding*2,tilesHigh*(height+padding)+padding*2);
		bg.pos = new luxe.Vector(pos.x-padding,pos.y-padding);
		//		  new luxe.Vector(70*5+20+padding*2,70*5+20+padding*2),

		if (controls)
			randomize(10);
	}

	public function levelComplete (noticeRandomization=true){
		if (randomized == false && noticeRandomization) return false;
		for (x in 0...tilesWide){
			for (y in 0...tilesHigh){

				if (Levels.levels[level].tiles[y*tilesWide+x] != getTile(x,y).sym){
					trace('Not complete! Tile was '+ getTile(x,y).sym + ' but meant to be '+Levels.levels[level].tiles[y*tilesWide+x] );
					return false;
				}
			}
		}
		trace("Complete!");
		return true;
	}


	function debugTiles(tiles:Array<Tile>){
		/*Sys.println("");
		for (y in 0...tilesWide){
			for (x in 0...tilesHigh){
				Sys.print(tiles[(y*5)+x].sym + " ");
			}
			Sys.println("");
		}
		Sys.println("");*/
	}

	public function getTile (x,y,wrap=false,withAGoodPos=true):Tile{
		if (wrap) x %= tilesWide;
		if (wrap) y %= tilesHigh;
		if (x<0 && wrap) x = tilesWide+x;
		if (y<0 && wrap) y = tilesHigh+y;

		for (t in tiles){
			if (t == null) throw("lolwat null tile");
			if (t.x == x && t.y == y && t.goodpos == withAGoodPos){
				return t;
			}
		}
		trace('No tile was found for $x : $y');
		return null;
	}
}
