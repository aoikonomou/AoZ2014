package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent; // <-- import MouseEvent Class
	import flash.events.EventDispatcher; // <-- In order to be able to dispatch events?
	import flash.events.Event;

	/*public class CustomEvent extends flash.events.Event {
		public static const CUSTOM_EVENT: String = "test";
	}*/

	public class startButton extends MovieClip {


		


		public function startButton() {
			// constructor code

			// Allow it to be clicked
			this.addEventListener(MouseEvent.CLICK, clickHandler);

			// Handle the click



		}



		function clickHandler(event: MouseEvent): void {
			trace("You clicked on the start button!");

			// Dispatch an event here that can be captured by any other object in the program. Hmm, that sounds good, I wonder if there are any drawbacks or other ways to communicate between objects
			var test:String = "test";
			dispatchEvent(new Event(test,true));
			trace("Event dispatched?");
		}







	}

}