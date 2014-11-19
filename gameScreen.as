package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	import flash.geom.ColorTransform;// To be able to change tile colours.


	public class gameScreen extends MovieClip
	{

		var tileArray:Array = new Array();
		var tileDistanceX:int = 1;
		var tileDistanceY:int = 1;

		// calculate the number of tiles dependant on the size of the screen
		
		var tilesColumns:int = Math.abs(aoz.screenXsize / aoz.tileSize);
		var tilesRows:int = Math.abs(aoz.screenYsize / aoz.tileSize);
		// var totalTiles:int = tilesRows * tilesColumns;


		public function gameScreen()
		{

			trace(tilesRows);
			trace(tilesColumns);

			// Create floor tiles
			// Instantiate new grass tiles
			for (var i=0; i<tilesColumns; i++)
			{

				tileArray.push(new Array());
				for (var j=0; j<tilesRows; j++)
				{

					// Bellow I am creating a single kind of green tile. I need to create different types of tiles in the next version.

					tileArray[i][j] = new tile  ;
					tileArray[i][j].width = aoz.tileSize;
					tileArray[i][j].height = aoz.tileSize;
					tileArray[i][j].x +=  tileDistanceX;
					tileArray[i][j].y +=  tileDistanceY;
					tileDistanceY +=  aoz.tileSize;
					addChild(tileArray[i][j]);

				}

				tileDistanceY = 1;
				tileDistanceX +=  aoz.tileSize;
			}

			// Create block tiles
			// Create pickup tiles
			// Create enemy tiles
			// Create exit tile
			// Create player tile

			createPlayerTile();

			// Create interface

		}

		function changeTileColour()
		{


			/*
			Unlike the majority of other simple properties such as alpha, x, y, width, and height, the color of an object cannot be directly changed on the object itself. Instead you must create a new instance of the ColorTransform class, any color transformation desired are to be applied to this instance, and then this instance is used to overwrite the actual ColorTransform property attached to the target object. This property itself is a sub property of the Transform property of the Display objects such as Shapes, Sprites, and MovieClips.
			*/

			var myColorTransform = new ColorTransform();
			myColorTransform.color = 0xFFFFFF;
			//myTargetObject.transform.colorTransform = myColorTransform;


		}


		function createPlayerTile()
		{

			// Creating hero color. Must be done like this. No direct access to color property of a movieclip.
			var heroColor = new ColorTransform();
			heroColor.color = 0xFFFFFF;

			trace(tilesRows);
			trace(tilesColumns);

			// Assigning hero colour to a tile
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].transform.colorTransform = heroColor;


		}


	}

}