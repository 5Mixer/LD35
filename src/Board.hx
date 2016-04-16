package ;

class Board extends luxe.Entity {

	public var tiles:Array<Tile>;

	var tilesWide = 5;
	var tilesHigh = 5;

	public function new () {
		tiles = new Array<Tile>();

		for (x in 0...tilesWide){
			for (y in 0...tilesHigh){
				tiles[y * tilesWide + x] = new TriangleTile(x,y);
			}
		}

		super({
			name:"Board"
		});
	}
	public function getTile (x,y){
		return tiles[y * tilesWide + x];
	}
}
