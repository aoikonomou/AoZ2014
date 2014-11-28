package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	import flash.geom.ColorTransform;
	import flashx.textLayout.operations.InsertTextOperation;

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
		var type:Array = [0,1,2,3,4,5];// 0:grass, 1:block, 2:zombie, 3:pickup, 4:hero, 5:exit

		// This is to keep track of where the hero and exit tiles are in the array during the game
		var currentHeroPosinArrayColumn:int;
		var currentHeroPosinArrayRow:int;

		var currentExitPosinArrayColumn:int;
		var currentExitPosinArrayRow:int;

		// This is where you keep track of a tile whilst it is being switched to another type
		var currentArrayColumn:int;
		var currentArrayRow:int;

		public function gameScreen()
		{

			createGrassTiles();// Instantiate new grass tiles
			// removeGrassTiles(); // This works
			//createMainPath();// Includes exit and hero tile on the path.
			// Scan and replace function?

		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function createGrassTiles()
		{
			for (var i=0; i<tilesColumns; i++)
			{
				tileArray.push(new Array());
				for (var j=0; j<tilesRows; j++)
				{
					var tileType:int = 0;// This is the grass tile. Just making it readable instead of using numbers to pass the type to the objects when they are created below

					// Bellow I am creating a grass tile.

					createTile(i,j,tileType);

					setTileSize(i,j);// Because many functions will be using this I don't want to keep rewriting so I made a function for it
				
					colorizeTile(i,j,tileType);// Call the tile colorisation function with the position of the tile in the array and its type. The function knows what colour to make it based on the description you are passing to it

					
					trace(tileArray.length);
					//trace(i,j);
					tileArray[i][j].x +=  tileDistanceX;
					tileArray[i][j].y +=  tileDistanceY;
					tileDistanceY +=  aoz.tileSize;
					trace(tileArray[i][j].x);

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


		public function createMainPath()
		{

			// Start around the middle of the screen at the top
			var randomBegginingTile:int;
			randomBegginingTile = randomNumberRange((tilesColumns/2)-(tilesColumns/4),(tilesColumns/2)+(tilesColumns/4));// Random starting point around the middle of the columns

			//randomBegginingTile = 1;// Debugging code, remove

			createTile(randomBegginingTile,0,5);// Create the exit tile here first. Parameters are column, row, tile type.

			var previousTile = randomBegginingTile;// Keeps track of the current tile to create new ones from in terms of position
			var nextRandomTile:int;
			var randomNumber:int;// a random number between -1 to 1 added to previousTile variable
			trace("random start tile: " + randomBegginingTile);

			var leftEdgeCheck:int = 0;// Set the left edge of the screen in terms of columns
			var rightEdgeCheck:int = tilesColumns - 1;// Set the right edge of the screen in terms of columns

			// Now start making the path. Start from row 1 instead of zero because on 0 you have the exit tile.
			for (var row=1; row<tilesRows-1; row++)
			{

				// Select a random tile from the 3 tiles in fron of (going downards) the current tile. You 'll pass that number as a column number in the next iteration
				randomNumber = (previousTile-1) + Math.round(Math.random()*(2));

				if (randomNumber >= leftEdgeCheck && randomNumber <= rightEdgeCheck)
				{
					nextRandomTile = randomNumber;
					previousTile = nextRandomTile;

				}
				else
				{
					if (randomNumber < leftEdgeCheck)
					{
						nextRandomTile = randomNumber + 1;
						trace("Out of bounds left. Column: "+row);
					}

					if (randomNumber > rightEdgeCheck)
					{
						nextRandomTile = randomNumber - 1;
						trace("Out of bounds right. Column: "+row);
					}

				}

				createTile(nextRandomTile,row,1);
				tileArray[nextRandomTile][row].x = -20;

			}

			randomNumber = (previousTile-1) + Math.round(Math.random()*(2));
			nextRandomTile = randomNumber;

			// I need to write a function to check edges and send all tiles through it? Just to be on the safe side?. I certainly need to check the hero tile for going out of bounds

			createTile(nextRandomTile,tilesRows-1,4);// Create hero tile

		}


		// Put trees, rocks and other stuff on the level
		public function populateLevel()
		{

			for (var i=0; i<tilesColumns; i++)
			{

				for (var j=0; j<tilesRows; j++)
				{
				}
			}
		}


		public function createTile(column,row,type):void
		{

			// X/Y position on screen of original tile to be replaced by exit tile
			if (tileArray[column][row])
			{
				var currentPosX:int = tileArray[column][row].x;
				var currentPosY:int = tileArray[column][row].y;

				// Remove original tile. To be replaced with exit tile below
				removeChild(tileArray[column][row]);// Remove from screen
				tileArray[column][row] = null;// Remove reference to object for garbage collector to collect it

				// Assigning tile colour according to type
				trace("I 'm inside the if statetement");
			}
			
			tileArray[column][row] = new tile(column,row,type);
			
			trace("I created the tile ", column, row, tileArray[column][row]);
			tileArray[column][row].x = currentPosX;
			tileArray[column][row].y = currentPosY;
			trace("The x value of the tile is "+tileArray[column][row].x);
			// setTileSize(column,row);
			
			addChild(tileArray[column][row]);

			
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


		public function setTileSize(column,row):void
		{
			if (tileArray[column][row])
			{
				tileArray[column][row].width = aoz.tileSize;
				tileArray[column][row].height = aoz.tileSize;
				trace("I am in setTileSize function now");
				trace(column, row, tileArray[column][row]);
				
			}
		}

		public function colorizeTile(column,row,type):void
		{

			// Creating tile color. Must be done like this. No direct access to color property of a movieclip.
			var tileColor = new ColorTransform();
			var tileColours:Array = new Array();

			tileColours[0] = 0x6ABF63;// Green colour for grass
			tileColours[1] = 0xAEAEAE;// Gray colour for blocks/rocks
			tileColours[2] = 0xF4A460;// Brown colour for path
			tileColours[3] = 0x4B78F4;// Blue colour for pickups
			tileColours[4] = 0xFDFF00;// Yellow colour for player
			tileColours[5] = 0xF2AF0F;// Orange colour for exit
			tileColours[6] = 0xF20F0F;// Red colour for Zombies


			tileColor.color = tileColours[type];


			/*
			// Can also be done like this. This is a dynamic class. We don't know it's properties before runtime I think. We may be able to add more during run time?
			
			var colours:Object = new Object();
			colours.green=0x6ABF63;
			colours.brown=0xF4A460;
			colours.grey=0xAEAEAE;
			colours.blue=0x4B78F4;
			colours.red=0xF20F0F;
			colours.orange=0xF2AF0F;
			colours.yellow=0xFDFF00;
			*/

			tileArray[column][row].transform.colorTransform = tileColor;
			trace("I finished colorising now");

		}


		function randomNumberRange(minNum:int, maxNum:int):int
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

	}

}