package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	

	public class gameScreen extends MovieClip
	{

		var tileArray:Array = new Array();
		var tileDistanceX:int = 1;
		var tileDistanceY:int = 1;

		// calculate the number of tiles dependant on the size of the screen
		var tilesAcross:int = Math.abs(aoz.screenXsize / aoz.tileSize);
		var tilesAlong:int = Math.abs(aoz.screenYsize / aoz.tileSize);
		// var totalTiles:int = tilesAcross * tilesAlong;


		public function gameScreen()
		{
			
			trace(tilesAcross);
			trace(tilesAlong);
			
			// Create floor tiles
			// Instantiate new grass tiles
			for (var i=0; i<tilesAlong; i++)
			{
			
				tileArray.push(new Array());
				for (var j=0; j<tilesAcross; j++)
				{

					tileArray[i][j] = new tile;
					tileArray[i][j].width = aoz.tileSize;
					tileArray[i][j].height = aoz.tileSize;
					tileArray[i][j].x += tileDistanceX;
					tileArray[i][j].y += tileDistanceY;
					tileDistanceX +=  aoz.tileSize;
					addChild(tileArray[i][j]);

				}
				
					tileDistanceX = 1;
					tileDistanceY +=  aoz.tileSize;
			}

			// Create block tiles
			// Create pickup tiles
			// Create enemy tiles
			// Create exit tile
			// Create player tile
			// Create interface

		}

	}

}