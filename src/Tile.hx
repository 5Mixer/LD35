package ;

import phoenix.Texture;

class Tile extends luxe.Sprite {
	public function new (x,y,sprite){
		var image = Luxe.resources.texture('assets/$sprite.png');

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

}
