package {

	import flash.display.MovieClip;
	import flash.events.Event;

	public class aoz extends MovieClip {

		// I suppose the stuff I put in here are class oriented variables. Not belonging to specific functions
		// What is a class variable? Well, good question. An object variable that is more general to the object that any of its functions. Something like it's height for example if it was a human

		var screen1: startScreen = new startScreen; // I 've created a MovieClip that contains all the stuff for the first screen. I am instantiating it here but I need to add to the stage also (in the main function)

		// Screen resolution related variables (for multiple devices, but what is the target device? Actually, desktop for once)
		static var screenXsize:int = 800; // static keyword makes it accessible directly from other objects
		static var screenYsize:int = 600;
		static var tileSize:int = 32;
		
		public function aoz() {
			// constructor code

			// No straight forward way to change resolution at runtime. It is possible (I think) by putting objects on the stage and having the stage rescale but not by directly setting the valus in the commands bellow.

			//trace(stage.stageWidth);
			//trace(stage.stageHeight);

			// Question 2, shall i make the first screen as a separate file and then load it? How would they communicate with the main game area?
			
			addChild(screen1); // To see it you need to add it to the stage. Otherwise it is invisible

			screen1.x = 100; // Now position it where you want it on the stage
			screen1.y = 150;

			// Now how could i communicate a variable back here from that object? 

			screen1.addEventListener("test", updateMessageFromMovieClip); // When I click on that button on that object I need it to know about it and do soemthing

		}

		// This is what the button click will do (but it is not working. What would happen if it did, well, I want it to update a variable on my master programme and delete itself and then load another MovieClip which will be of the main game scene.

		function updateMessageFromMovieClip(test) {

			var messageFromMovieClipEvent = test;
			trace(messageFromMovieClipEvent);
			getRidofstartScreen();
			startGame();
			
		}

		function getRidofstartScreen() {

			removeChild(screen1);
			screen1 = null;
			// Also remember not to reference it anywhere else. If you want to test if its still on the stage somewhere use the .stage property.

		}
		
		
		function startGame(){
			
			var screen2:gameScreen = new gameScreen;
			addChild(screen2);
			
			
			}
			
	}

}
