package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	
	
	public class aoz extends MovieClip {
		
		// I suppose the stuff I put in here are class oriented variables. Not belonging to specific functions
		
		var messageFromMovieClip:String;
		
		
		
		public function aoz() {
			// constructor code
		

			// No straight forward way to change resolution at runtime. It is possible (I think) by putting objects on the stage and having the stage rescale but not by directly setting the valus in the commands bellow.
		
			trace(stage.stageWidth);
			trace(stage.stageHeight);
			
			// Question 2, shall i make the first screen as a separate file and then load it? How would they communicate?
			
			var screen1:startScreen = new startScreen  ;
			addChild(screen1);

			screen1.x = 100;
			screen1.y = 150;
			
			// Now how could i communicate a variable back here from that object? 
			
			screen1.addEventListener(startButton.CUSTOM_EVENT, updateMessageFromMovieClip);
			
			
		}
		
		function updateMessageFromMovieClip(){
			
			messageFromMovieClip = "Meow";
			trace(messageFromMovieClip);
			}
		
		
	}
	
}
