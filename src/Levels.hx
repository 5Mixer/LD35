package ;

class Levels {
	public function new () {

	}
	public static var levels = [
		{
			message : "Hi! Slide the columns and rows on the left grid,\nto make it look like the right grid.",
			tiles: ["S","T",
					"T","S"]
		},{
			message: "That was easy, but it'll get more difficult!",
			tiles: ["S","T","S",
					"T","T","T",
					"S","T","S"]
		},{
			message: "Let's throw some circles in!",
			tiles: ["C","S","S","C",
					"S","T","T","S",
					"S","T","T","S",
					"C","S","S","C",]
		},{
			message: "Good job! Try this.",
			tiles: ["C","S","T","C",
					"C","T","S","C",
					"C","S","T","C",
					"C","T","S","C",]
		},{
			message: "Nice work, how about 5 by 5?",
			tiles: ["T","T","T","T","T",
					"T","C","T","C","T",
					"T","T","C","C","T",
					"T","S","T","S","T",
					"T","S","S","S","T",]
		},{
			message: "Final one - The crazy 6 by 6. It's possible!",
			tiles: ["T","T","T","T","T","T",
					"T","C","S","S","C","T",
					"T","S","C","C","S","T",
					"T","S","C","C","S","T",
					"T","C","S","S","C","T",
					"T","T","T","T","T","T",]
		}

	];
}
