package 
{

	import flash.display.MovieClip;
	 import flash.events.MouseEvent; // <-- import MouseEvent Class


	public class startButton extends MovieClip
	{


		public function startButton()
		{
			// constructor code

			// Allow it to be clicked
			this.addEventListener(MouseEvent.CLICK, clickHandler);

			// Handle the click
			
			function clickHandler(event:MouseEvent):void
			{
				trace("You clicked on the start button!");
			}

		}
	}

}