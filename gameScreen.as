package 
{

	import flash.display.MovieClip;
	import tile;


	public class gameScreen extends MovieClip
	{

		var tileArray:Array =[];

		public function gameScreen()
		{


			for (var i=0; i<800; i++)
			{

				//Instantiate new grass tiles


			 tileArray[i] = new tile;
				tileArray[i].x = i * 5;
				addChild(tileArray[i]);

			}



			// Create floor tiles
			// Create block tiles
			// Create pickup tiles
			// Create enemy tiles
			// Create exit tile
			// Create player tile
			// Create interface

			// 
		}
	}

}