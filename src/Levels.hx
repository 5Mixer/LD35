package ;

class Levels {
	public function new () {

	}
	public static var levels = [
		{
			message : "Hi! Shift the columns and rows on the left grid, to make it appear like the second.",
			tiles: ["S","T",
		  		  "T","S"]
		},{
			message: "That was easy, but it'll get more difficult!",
			tiles: ["S","T","S",
					"T","T","T",
					"S","T","S"]

		},{
			message: "Good, you're getting the hang of it.",
			tiles: ["C","S","S","C",
					"S","T","T","S",
					"S","T","T","S",
					"C","S","S","C",]
		}

	];
}
