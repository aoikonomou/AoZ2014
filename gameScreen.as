package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	//import flash.Math;



	public class gameScreen extends MovieClip
	{

		var tileArray:Array = new Array();
		var tileDistance:int = 1;
		
		

		// calculate the number of tiles dependant on the size of the screen

		var tilesAcross:int = Math.abs(aoz.screenXsize / aoz.tileSize);
		var tilesAlong:int = Math.abs(aoz.screenYsize / aoz.tileSize);
		var totalTiles:int = tilesAcross * tilesAlong;


		public function gameScreen()
		{
			
			trace(tilesAcross);
			trace(tilesAlong);
			
			// Create floor tiles
			//Instantiate new grass tiles
			for (var i=0; i<=tilesAcross; i++)
			{
				tileArray.push(new Array());
				for (var j=0; j<=tilesAlong; j++)
				{

					tileArray[i][j] = new tile;
					
					tileArray[i][j].x += tileDistance;
					tileArray[i][j].y += tileDistance;
					tileDistance +=  aoz.tileSize;
					addChild(tileArray[i][j]);
					
					trace("blah");
					trace(tileArray[i][j]);

				}
			}

			
			// Create block tiles
			// Create pickup tiles
			// Create enemy tiles
			// Create exit tile
			// Create player tile
			// Create interface

			// 
		}

		function setTileSize(size)
		{


		}

	}

}