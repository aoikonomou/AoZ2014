﻿package 
{

	import flash.display.MovieClip;
	import tile;
	import flash.display.InteractiveObject;
	import flash.geom.ColorTransform;
	import flashx.textLayout.operations.InsertTextOperation;

	// To be able to change tile colours.


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

			createGrassTiles();// Instantiate new grass tiles
			// removeGrassTiles(); // This works
			createExitTile();
			createMainPath();
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

					setTileSize(i,j);// Because many functions will be using this I don't want to keep rewriting so I made a function for it

					// tileArray[i][j].width = aoz.tileSize;
					// tileArray[i][j].height = aoz.tileSize;

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

		
		public function createMainPath(){
			
			
			// start from the bottom. hmmm, or, actually, why not, start from the top. How many iterations. As many as rows
			
			
			var randomBegginingTile= 1 + Math.round(Math.random()*(tilesColumns-2)); // Random starting point
			var previousTile = randomBegginingTile; // To update as the new starting position for every iteration of the loop
			
				trace("random start tile: " + randomBegginingTile);
				tileArray[randomBegginingTile][0].x = -20;
			
			
			for (var i=1;i<tilesRows;i++){
				
				var randomNextTile = (previousTile-1) + Math.round(Math.random()*(2));
				previousTile = randomNextTile;
				tileArray[randomNextTile][i].x = -20;
				
				}
			
			
			
			}
		
		
		public function createExitTile()
		{

			// Making the type of the tile easily readable in the code instead of assigning a number
			var tileType = 5;// 5 For exit

			// Finding the position of the exit tile on the array
			currentExitPosinArrayColumn = Math.round(tilesColumns/2)-1;// Halfway between the columns
			currentExitPosinArrayRow = 0;// Top row

			// X/Y position on screen of original tile to be replaced by exit tile
			var currentExitPosX:int = tileArray[currentExitPosinArrayColumn][currentExitPosinArrayRow].x;
			var currentExitPosY:int = tileArray[currentExitPosinArrayColumn][currentExitPosinArrayRow].y;

			// Remove original tile. To be replaced with exit tile below
			removeChild(tileArray[currentExitPosinArrayColumn][0]);// Remove from screen
			tileArray[currentExitPosinArrayColumn][0] = null;// Remove reference to object for garbage collector to collect it

			// Assigning exit colour to a tile

			tileArray[currentExitPosinArrayColumn][0] = new tile(tileType,currentExitPosinArrayColumn,currentExitPosinArrayRow);
			tileArray[currentExitPosinArrayColumn][0].x = currentExitPosX;
			tileArray[currentExitPosinArrayColumn][0].y = currentExitPosY;
			setTileSize(currentExitPosinArrayColumn,0);
			addChild(tileArray[currentExitPosinArrayColumn][0]);

			colorizeTile(currentExitPosinArrayColumn,0,"exit");// Call the tile colorisation function with the position of the tile in the array and its type. The function knows what colour to make it based on the description you are passing to it


		}

		public function createPlayerTile()
		{

			// Making the type of the tile easily readable in the code instead of assigning a number
			var tileType = 4;// 4 For hero

			// Removing the tile grass tile where the hero tile will go. Probably can do better that this in a next version by not making it at all a grass tile at the beggining.

			// Finding the position of the exit tile on the array
			currentHeroPosinArrayColumn = Math.round(tilesColumns/2)-1;// Halfway between the columns
			currentHeroPosinArrayRow = tilesRows - 1;// Top row

			// X/Y position on screen of original tile to be replaced by exit tile
			var currentHeroPosX:int = tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow].x;
			var currentHeroPosY:int = tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow].y;

			trace(currentHeroPosX);
			trace(currentHeroPosY);

			// Remove original tile. To be replaced with exit tile below
			removeChild(tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow]);// Remove from screen
			tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow] = null;// Remove reference to object for garbage collector to collect it


			// Assigning hero colour to a tile
			tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow] = new tile(tileType,currentHeroPosinArrayColumn,currentHeroPosinArrayRow);
			tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow].x = currentHeroPosX;

			setTileSize(currentHeroPosinArrayColumn,currentHeroPosinArrayRow);

			tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow].y = currentHeroPosY;
			addChild(tileArray[currentHeroPosinArrayColumn][currentHeroPosinArrayRow]);
			
			colorizeTile(currentHeroPosinArrayColumn,currentHeroPosinArrayRow,"player");// Call the tile colorisation function with the position of the tile in the array and its type. The function knows what colour to make it based on the description you are passing to it

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
			tileArray[column][row].width = aoz.tileSize;
			tileArray[column][row].height = aoz.tileSize;
		}

		public function colorizeTile(column,row,type):void
		{

			// Creating tile color. Must be done like this. No direct access to color property of a movieclip.
			var tileColor = new ColorTransform();
			var tileColours:Array = new Array();

			tileColours['grass'] = 0x6ABF63;// Green colour for grass
			tileColours['block'] = 0xAEAEAE;// Gray colour for blocks/rocks
			tileColours['path'] = 0xF4A460;// Brown colour for path
			tileColours['pickup'] = 0x4B78F4;// Blue colour for pickups
			tileColours['player'] = 0xFDFF00;// Yellow colour for player
			tileColours['exit'] = 0xF2AF0F;// Orange colour for exit
			tileColours['zombie'] = 0xF20F0F;// Red colour for Zombies


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

		}


	}

}