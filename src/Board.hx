package ;


import org.gesluxe.events.GestureEvent;
import org.gesluxe.gestures.SwipeGesture;

class Board extends luxe.Entity {

	public var tiles:Array<Tile>;

	var tilesWide = 5;
	var tilesHigh = 5;

	public function new () {
		tiles = new Array<Tile>();

		for (x in 0...tilesWide){
			for (y in 0...tilesHigh){
				var tile:Tile = null;

				if (Math.random() > .5){
					tile = new TriangleTile(x,y);
				}else{
					tile = new SquareTile(x,y);
				}
				tiles[y * tilesWide + x] = tile;
			}
		}

		debugTiles(tiles);

		var swipe = new SwipeGesture();
		swipe.events.listen(GestureEvent.GESTURE_RECOGNIZED, onGesture);


		super({
			name:"Board"
		});
	}

	function onGesture(event:GestureEventData)
	{
		var col = Math.round((event.gesture.location.x-50)/60);
		var row = Math.round((event.gesture.location.y-50)/60);

		var x = cast(event.gesture,SwipeGesture).offsetX > 0 ? true : false;
		var y = cast(event.gesture,SwipeGesture).offsetY > 0 ? true : false;

		if (cast(event.gesture,SwipeGesture).offsetX == 0){
			trace('Swipe up/down! Column: ${col+1}, down:$y');
			shiftColumn(col,y);
		}else if (cast(event.gesture,SwipeGesture).offsetY == 0){
			trace('Swipe L/R! Row: ${row+1}, right:$x');
			shiftRow(row,x);
		}
	}

	function shiftRow(row:Int,right){
		var newTiles = tiles;

		var offset = (right) ? 1 : -1;

		debugTiles(newTiles);
		for (x in 0...tilesWide){
			//getTile(x,row,true).color = new luxe.Color(255,100,100);
			getTile(x,row,true).setPos(x+offset,row,true);
			newTiles[getTileFromTiles(x,row,true)] = getTile(x+offset,row,true);
		}

		debugTiles(newTiles);
		tiles = newTiles;

	}

	public function getTileFromTiles (x,y,wrap=false){
		if (wrap) x %= tilesWide;
		if (wrap) y %= tilesHigh;
		if (x<0) x = x+5;
		if (y<0) y = y+5;

		return y * tilesWide + x;
	}

	function shiftColumn (col:Int,down){
		var newTiles = tiles;

		var offset = (down) ? 1 : -1;

		for (y in 0...tilesHigh){
			//getTile(col,y,true).color = new luxe.Color(255,100,100);
			getTile(col,y,true).setPos(col,y+offset,true);
			trace(getTileFromTiles(col,y,true));
			newTiles[getTileFromTiles(col,y,true)] = getTile(col,y+offset,true);

		}

		tiles = newTiles;


		debugTiles(tiles);
	}

	function debugTiles(tiles:Array<Tile>){
		Sys.println("");
		for (y in 0...tilesWide){
			for (x in 0...tilesHigh){
				Sys.print(tiles[(y*5)+x].sym + " ");
			}
			Sys.println("");
		}
		Sys.println("");
	}

	public function getTile (x,y,wrap=true){
		if (wrap) x %= tilesWide;
		if (wrap) y %= tilesHigh;
		if (x<0) x = -x;
		if (y<0) y = -y;

		return tiles[y * tilesWide + x];
	}
}
