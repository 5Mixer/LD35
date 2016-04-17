package ;

import phoenix.Texture;

class Tile extends luxe.Sprite {
	public var sym = "!";
	public var x = -100;
	public var y = -100;
	public var newx = -100;
	public var newy = -100;
	public var goodpos = true;

	public function new (x,y,sprite){
		var image = Luxe.resources.texture('assets/$sprite.png');

		this.x = x;
		this.y = y;

		var width = 40;
		var height = 40;
		var padding = 20;

		//keep pixels crisp when scaling them, for pixel art
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			pos: new luxe.Vector(50 + x*(width+padding),50 + y*(height+padding)),
			size: new luxe.Vector(width,height),
			texture: image
		});
	}

	public function setPos (_x,_y,wrap=true){
		if (wrap) _x %= 5;
		if (wrap) _y %= 5;
		if (_x<0) _x = 4;
		if (_y<0) _y = 4;

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

		var width = 40;
		var height = 40;
		var padding = 20;

		pos = new luxe.Vector(50 + this.x*(width+padding),50 + this.y*(height+padding));
	}

}
