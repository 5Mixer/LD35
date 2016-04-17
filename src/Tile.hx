package ;

import phoenix.Texture;

class Tile extends luxe.Sprite {
	public var sym = "!";
	public var x = -100;
	public var y = -100;
	public var newx = -100;
	public var newy = -100;
	public var goodpos = true;
	var board:Board;

	public function new (x,y,sprite,_board){
		var image = Luxe.resources.texture('assets/$sprite.png');

		board = _board;

		this.x = x;
		this.y = y;

		var width = 70;
		var height = 70;
		var padding = 10;

		//keep pixels crisp when scaling them, for pixel art
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			pos: new luxe.Vector(board.pos.x + x*(width+padding),board.pos.y + y*(height+padding)),
			size: new luxe.Vector(width,height),
			origin: new luxe.Vector(-padding/2,-padding/2),
			texture: image
		});
	}

	public function setPos (_x,_y,wrap=true){
		if (wrap) _x %= board.tilesWide;
		if (wrap) _y %= board.tilesHigh;
		if (_x<0) _x = board.tilesWide+_x;
		if (_y<0) _y = board.tilesHigh+_y;

		this.newx = _x;
		this.newy = _y;

		trace("Was at "+this.x+" : "+this.y+" will be moving to "+this.newx+" : "+this.newy+" when showPos() is called.");

		goodpos = false;

	}
	public function showPos () {
		goodpos = true;

		this.x = newx;
		this.y = newy;
		trace("Now at "+this.x+" : "+this.y);

		var width = 70;
		var height = 70;
		var padding = 10;


		luxe.tween.Actuate.tween( pos, 0.3, { x:board.pos.x + x*(width+padding), y: board.pos.y + y*(height+padding)} );
		//pos = new luxe.Vector(50 + this.x*(width+padding),50 + this.y*(height+padding));
	}

}
