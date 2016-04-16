package ;

import phoenix.Texture;

class Tile extends luxe.Sprite {
	public var sym = "!";
	var x = -100;
	var y = -100;
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

	public function setPos (x,y,wrap=false){
		trace("Was at "+this.x+" : "+this.y);
		if (wrap) x %= 5;
		if (wrap) y %= 5;
		if (x<0) x = x+5;
		if (y<0) y = y+5;

		this.x = x;
		this.y = y;
		trace("Now at "+this.x+" : "+this.y);

		var width = 40;
		var height = 40;
		var padding = 20;

		pos = new luxe.Vector(50 + x*(width+padding),50 + y*(height+padding));
	}

}
