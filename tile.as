package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;


	public class tile extends MovieClip
	{

		var sizeX:int;
		var sizeY:int;
		
		var tileArrayPosX:int;
		var tileArrayPosY:int;
		

		public function tile(ArrayPosX,ArrayPosY,tileType)
		{
			// constructor code
			//trace(type);
			
			tileArrayPosX= ArrayPosX;
			tileArrayPosY= ArrayPosY;

			
			if (tileType == 0)
			{
				this.addEventListener(MouseEvent.CLICK,moveHereifyouCan);
			}
			
			if (tileType == 4)
			{
				this.addEventListener(MouseEvent.CLICK,sayHello);
			}

		}


		function sayHello(event: MouseEvent):void
		{
			trace("Hello from hero");
			trace("You should see the game interface when you click the hero");
		}
		
		function moveHereifyouCan(event:MouseEvent):void{
			
			// pass my coordinates to master or check myself? how do i check myself? i need access to that array. 

			
			}
		
		

	}

}