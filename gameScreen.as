package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	import flash.geom.ColorTransform;// To be able to change tile colours.


	public class gameScreen extends MovieClip
	{
		var tileArray:Array = new Array();
		var tileArrayAroundHero = new Array();// to hold the positions around the hero tile
		var tileDistanceX:int = 1;// This was to leave a gap between tiles but I don't think I am using it right now
		var tileDistanceY:int = 1;// This was to leave a gap between tiles but I don't think I am using it right now

		// calculate the number of tiles dependant on the size of the screen
		var tilesColumns:int = Math.abs(aoz.screenXsize / aoz.tileSize);
		var tilesRows:int = Math.abs(aoz.screenYsize / aoz.tileSize);
		// var totalTiles:int = tilesRows * tilesColumns;

		// Different types of tiles to be created
		var type:Array = [0,1,2,3,4,5];

		// 0 = grass
		// 1 = block
		// 2 = zombie
		// 3 = pickup
		// 4 = hero
		// 5 = exit

		// This is to keep track of where the hero tile is in the array during the game
		var currentHeroPosinArrayColumn:int;
		var currentHeroPosinArrayRow:int;
		
		// This is to keep track of where the exit tile is in the array during the game
		var currentExitPosinArrayColumn:int;
		var currentExitPosinArrayRow:int;
		

		public function gameScreen()
		{
			trace(tilesRows);
			trace(tilesColumns);

			createGrassTiles();// Instantiate new grass tiles
			// removeGrassTiles(); // This works
			createExitTile();
			//createMainPath();
			createPlayerTile();
		}

		public function createGrassTiles()
		{
			for (var i=0; i<tilesColumns; i++)
			{
				tileArray.push(new Array());
				for (var j=0; j<tilesRows; j++)
				{
					var tileType:int = 0;// This is the grass tile. Just making it readable instead of using numbers to pass the type to the objects when they are created below

					// Bellow I am creating a single kind of green tile. I need to create different types of tiles in the next version.
					tileArray[i][j] = new tile(tileType,i,j);
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
		}

		public function removeGrassTiles()
		{
			for (var i=0; i<tilesColumns; i++)
			{
				tileArray.push(new Array());
				for (var j=0; j<tilesRows; j++)
				{
					var randomNumber = Math.random();
					if (randomNumber > 0.5)
					{
						removeChild(tileArray[i][j]);
					}
				}

			}
		}

		public function createExitTile()
		{
			// Creating hero color. Must be done like this. No direct access to color property of a movieclip.
			var exitColor = new ColorTransform();
			exitColor.color = 0xFFA500;

			// Making the type of the tile easily readable in the code instead of assigning a number
			var tileType = 5;// 5 For exit

			currentExitPosinArrayColumn = Math.round(tilesColumns/2)-1; // Halfway between the columns
			currentExitPosinArrayRow = 0; // Top row
			
			
			removeChild(tileArray[currentExitPosinArrayColumn][0]);
			//tileArray[Math.round(tilesColumns/2)-1][tilesRows-1] = null;


			// Assigning exit colour to a tile
			
			tileArray[Math.round(tilesColumns/2)-1][0] = new tile(tileType,currentExitPosinArrayColumn,currentExitPosinArrayRow);
			tileArray[Math.round(tilesColumns/2)-1][0].x =currentExitPosinArrayColumn;
			tileArray[Math.round(tilesColumns/2)-1][0].y =currentExitPosinArrayRow;
			addChild(tileArray[Math.round(tilesColumns/2)-1][0]);
			tileArray[Math.round(tilesColumns/2)-1][0].transform.colorTransform = exitColor;

			// position the tile at the right spot

		}

		public function createPlayerTile()
		{

			// Creating hero color. Must be done like this. No direct access to color property of a movieclip.
			var heroColor = new ColorTransform();
			heroColor.color = 0xFFFF00;

			// Making the type of the tile easily readable in the code instead of assigning a number
			var tileType = 4;// 4 For hero

			// Removing the tile grass tile where the hero tile will go. Probably can do better that this in a next version by not making it at all a grass tile at the beggining.

			var heroArrayPosX=tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].x;
			var heroArrayPosY=tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].y;
			
			
			heroArrayPosX=tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].x = 100;
			heroArrayPosY=tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].y = 200;
			
			trace(heroArrayPosX);
			trace(heroArrayPosY);
			
			trace(tilesRows);


			removeChild(tileArray[Math.round(tilesColumns/2)-1][tilesRows-1]);
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1] = null;

			
			// Assigning hero colour to a tile
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1] = new tile(tileType,heroArrayPosX,heroArrayPosX);
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].x =heroArrayPosX;
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].y =heroArrayPosY;
			addChild(tileArray[Math.round(tilesColumns/2)-1][tilesRows-1]);
			tileArray[Math.round(tilesColumns/2)-1][tilesRows-1].transform.colorTransform = heroColor;



			// position the tile at the right spot

		}

		public function checkTilesAroundHero()
		{


			// First populate the checking array with the tiles around the hero

			/*
			tileArrayAroundHero[0] = currentHeroPosinArrayColumn - 1 and currentHeroPosinArrayRow -1  // top left
			tileArrayAroundHero[1] = currentHeroPosinArrayColumn and currentHeroPosinArrayRow -1      // top which is hero.y -1
			tileArrayAroundHero[2] = currentHeroPosinArrayColumn + 1 and currentHeroPosinArrayRow -1  // top right which is hero.x +1 and hero.y -1
			tileArrayAroundHero[3] = currentHeroPosinArrayColumn + 1 and currentHeroPosinArrayRow     // right which is hero.x +1
			tileArrayAroundHero[4] = currentHeroPosinArrayColumn + 1 and currentHeroPosinArrayRow +1  // bottomright which is hero.x+1 and hero.y +1
			tileArrayAroundHero[5] = currentHeroPosinArrayColumn and currentHeroPosinArrayRow +1      // bottom which is hero.y +1
			tileArrayAroundHero[6] = currentHeroPosinArrayColumn - 1 and currentHeroPosinArrayRow +1  // bottomleft which is hero.x -1 and hero.y +1
			tileArrayAroundHero[7] = currentHeroPosinArrayColumn - 1 and currentHeroPosinArrayRow     // left which is hero.x-1
			
			
			Now every time a tile is clicked, chedk it's coordinates against the above table. If they match, check they type of tile, if empty(i.e. grass) move the hero tile to this new coordinate and update the array accordingly.
			*/
		}

	}

}