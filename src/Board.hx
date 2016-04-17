package ;

import org.gesluxe.events.GestureEvent;
import org.gesluxe.gestures.SwipeGesture;

class Board extends luxe.Entity {

	public var tiles:Array<Tile>;

	public var tilesWide = 5;
	public var tilesHigh = 5;


	var width = 70;
	var height = 70;
	var padding = 10;

	var level = 0;

	public function new () {

		super({
			name:"Board",
			pos: new luxe.Vector(Luxe.screen.mid.x - 2.5*(width+padding), Luxe.screen.mid.y - 2.5*(width+padding))
		});

		tilesWide = tilesHigh = Math.floor(Math.sqrt(Levels.levels[level].tiles.length));


		tiles = new Array<Tile>();

		onLevelStart();


		var bg = new luxe.Sprite({
			texture: Luxe.resources.texture("assets/Board.png"),
			pos: Luxe.screen.mid,
			size: new luxe.Vector(80*5+20+padding*2,80*5+20+padding*2),
			depth: -1
		});

		debugTiles(tiles);

		var swipe = new SwipeGesture();
		swipe.events.listen(GestureEvent.GESTURE_RECOGNIZED, onGesture);


	}

	function onGesture(event:GestureEventData)
	{
		var col = Math.floor((event.gesture.location.x-pos.x)/80);
		var row = Math.floor((event.gesture.location.y-pos.y)/80);

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
	}
	public function onLevelStart () {
		tilesWide = tilesHigh = Math.floor(Math.sqrt(Levels.levels[level].tiles.length));

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
				}


				tiles[y * tilesWide + x] = tile;
			}
		}
	}

	public function levelComplete (){
		for (x in 0...tilesWide){
			for (y in 0...tilesHigh){

				if (Levels.levels[level].tiles[y*tilesWide+x] != getTile(x,y).sym){
					return false;
				}
			}
		}
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
			if (t.x == x && t.y == y && t.goodpos == withAGoodPos){
				return t;
			}
		}
		trace('No tile was found for $x : $y');
		return null;
	}
}
