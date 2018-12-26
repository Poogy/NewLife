/// @description Just like everything
// You can write your code in this editor
//Some Variables not for pgc
doorActivated = false;

//PGC

//Constants
scr_constants();

//Randomize
randomize();

//Room size
room_width = (CELL_WIDTH/16) * 720;
room_height = (CELL_HEIGHT/16) * 360;

//Set the grid width and height - Wie viele Objekte in den Raum passen
var width = room_width div CELL_WIDTH;
var height = room_height div CELL_HEIGHT;

//Create grids
grid = ds_grid_create(width, height);
platforms = ds_grid_create(width, height);
platforms_len = ds_grid_create(width, height);
platforms_start = ds_grid_create(width, height);

//Fill the grids with void
ds_grid_set_region(grid, 0, 0, width - 1, height - 1, VOID);
ds_grid_set_region(platforms, 0, 0, width - 1, height - 1, VOID);
ds_grid_set_region(platforms_len, 0, 0, width - 1, height - 1, VOID);
ds_grid_set_region(platforms_start, 0, 0, width - 1, height - 1, VOID);

//Set controller position to top left corner (Room boundings start pos)
var cx = 0;
var cy = 0;

//Place Walls around room
for(cx = 0; cx < width; cx++){
	ds_grid_set(grid, cx, 0, WALL);
	ds_grid_set(grid, cx, height - 1, WALL);
}
for(cy = 1; cy < height; cy++){
	ds_grid_set(grid, 0, cy, WALL);
	ds_grid_set(grid, width - 1, cy, WALL);
}

//Add Terrain
for(cx = 1; cx < width - 1; cx++){
	if(irandom_range(1,5) >= 3) ds_grid_set(grid, cx, 1, WALL);
	if(irandom_range(1,5) >= 3) ds_grid_set(grid, cx, height - 2, WALL);
}
for(cy = 2; cy < height - 1; cy++){
	if(irandom_range(1,5) >= 3) ds_grid_set(grid, 1, cy, WALL);
	if(irandom_range(1,5) >= 3) ds_grid_set(grid, width - 2, cy, WALL);
}


//Clamp - don´t move out of bounds
cx = clamp(cx, 1, width -1);
cy = clamp(cy, 1, height -1);

//Set controller position to top left corner (Inner room start pos)
var cx = 1;
var cy = 3; //3 Because of headspace on the upper platform

//Other variables
cy_headspaces = array_create(99); //saves every line, which creates platforms
cy_headspaces[0] = cy;
headspace = cy_headspaces[0];
headspace_cnt = 1; //amt of lines which were created
chance_wall = 0; //Determines if a wall is likely to be placed

//platform variables
platform_length = 0; //Temp counting variable for platforms grid
platform_amt = array_create(99); //[cy], contains amount of platforms for the specific cy

for(cy = 3; cy < height - 1; cy += headspace){ //For Y
	if(cy + headspace < height - 1){
		headspace = irandom_range(MIN_HEADSPACE, MAX_HEADSPACE);
		cy_headspaces[headspace_cnt] = headspace;
		headspace_cnt++;
	}
	
	for(cx = 1; cx < width - 1; cx++){ //For X

		if(cx == 2){ //Mimic 1. first place
			if(grid[# 1, cy] == WALL){
				ds_grid_set(grid, 2, cy, WALL); //2-Walls at front
				platform_length = 2;
				ds_grid_set(platforms, 2, cy, TILES[platform_length]); //Platform is 2 long
			}else if(grid[# 1, cy] == VOID){
				ds_grid_set(grid, 2, cy, VOID); //2-void at front
				ds_grid_set(platforms, 2, cy, VOID); //2-void at front
				platform_length = 0;
			}
		}else if(cx == width - 2){ //Last Place //Mimic last -1
			if(grid[# width - 3, cy] == WALL){
				ds_grid_set(grid, width - 2, cy, WALL); //2-Walls at end
				ds_grid_set(grid, width - 2, cy, TILE_LAST); //Last tile in platform
				platform_length = 0;
			}else if(grid[# width - 3, cy] == VOID){
				ds_grid_set(grid, width - 2, cy, VOID); //2-void at end
				ds_grid_set(platforms, width - 2, cy, VOID); //2-void at end
				platform_length = 0;
			}
		}else if(cx > 1){
			if(grid[# cx - 2, cy] == VOID && grid[# cx - 1, cy] == WALL){
				ds_grid_set(grid, cx, cy, WALL); //2-Walls
				platform_length = 2;
				ds_grid_set(platforms, cx, cy, TILES[platform_length]); //2-Walls
			}else if(grid[# cx - 2, cy] == WALL && grid[# cx - 1, cy] == VOID){
				ds_grid_set(grid, cx, cy, VOID); //2-void
				ds_grid_set(platforms, cx, cy, VOID); //2-void
				platform_length = 0;
			}else if(irandom_range(1,100) <= chance_wall){ //Wall oder Void setzen
				ds_grid_set(grid, cx, cy, WALL); //Wall wins
				platform_length++;
				ds_grid_set(platforms, cx, cy, TILES[platform_length]); //Wall wins
				chance_wall -= 5;
			}else{
				ds_grid_set(grid, cx, cy, VOID); //Wall fails
				ds_grid_set(platforms, cx, cy, VOID); //Wall fails
				platform_length = 0;
				chance_wall += 5;
				if(platforms[# cx - 1, cy] != VOID) ds_grid_set(platforms, cx - 1, cy, TILE_LAST);
			}
		}else if (cx == 1){ //Erster Block pro Reihe
			if(irandom_range(0,1) == 1){ //Wall oder Void setzen
				ds_grid_set(grid, cx, cy, WALL);
				ds_grid_set(platforms, cx, cy, TILE_FIRST);
				chance_wall = 90;
				platform_length = 1;
			}else{
				ds_grid_set(grid, cx, cy, VOID);
				ds_grid_set(platforms, cx, cy, VOID);
				chance_wall = 10;
				platform_length = 0;
			}
		}
	}
		tiles = 0; //kind of temp counting var to get the amt of platforms
		for(x0 = 1; x0 < width - 1; x0++){
			if(platforms[# x0, cy] == TILE_FIRST){
				tiles++;
				ds_grid_set(platforms_start, tiles, cy, x0);
			}else if(platforms[# x0, cy] == TILE_LAST){
				ds_grid_set(platforms_len, tiles, cy, x0 - platforms_start[# tiles, cy]);
			}
		}
		platform_amt[cy] = tiles;
}

//////////////////////////////////////////////////////////////////////////////
//Anhang unter der Platform													//
//////////////////////////////////////////////////////////////////////////////

//Fill in the room a bit more complex
cy = 4; //y of first inner room line drawn
cx = 0;
for(i = 1; i < height; i++){
	cy += cy_headspaces[i];
	if(cy_headspaces[i] >= 6){
		
		do{ //Unter einem block am anfang/ende einer platform
			cx = irandom_range(1, height - 1);
		}until (grid[# cx, cy - cy_headspaces[i] - 1] == WALL)
		&& (grid[# cx - 1, cy - cy_headspaces[i] - 1] == VOID
		||  grid[# cx + 1, cy - cy_headspaces[i] - 1] == VOID);
		
		//Walls platzieren
		if(cy_headspaces[i] == 6){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
		}else if(cy_headspaces[i] == 7){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
			ds_grid_set(grid, cx, cy - cy_headspaces[i] + 1, WALL);
		}else if(cy_headspaces[i] == 8){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
			ds_grid_set(grid, cx, cy - cy_headspaces[i] + 1, WALL);
			ds_grid_set(grid, cx, cy - cy_headspaces[i] + 2, WALL);
		}
		
		if(irandom_range(1,3) >= 2){ //2. Anhang spawnen	
			do{ //Unter einem block am anfang/ende einer platform
				cx = irandom_range(1, height - 1);
			}until (grid[# cx, cy - cy_headspaces[i] - 1] == WALL)
			&& (grid[# cx - 1, cy - cy_headspaces[i] - 1] == VOID
			&&  grid[# cx - 1, cy - cy_headspaces[i]] == VOID
			||  grid[# cx + 1, cy - cy_headspaces[i] - 1] == VOID
			&&  grid[# cx + 1, cy - cy_headspaces[i]] == VOID);
			
			//Walls platzieren
			if(cy_headspaces[i] == 6){
										    ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
			}else if(cy_headspaces[i] == 7){
										    ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
				if(irandom_range(1,2) == 1) ds_grid_set(grid, cx, cy - cy_headspaces[i] + 1, WALL);
			}else if(cy_headspaces[i] == 8){
				ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL);
				if(irandom_range(1,2) == 1){ds_grid_set(grid, cx, cy - cy_headspaces[i] + 1, WALL);
				if(irandom_range(1,2) == 1) ds_grid_set(grid, cx, cy - cy_headspaces[i] + 2, WALL);}
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////
		//Doppelte Plattform														   //
		/////////////////////////////////////////////////////////////////////////////////

		if(true){ //Etwas auf die Platform spawnen
			
			newCy = cy - cy_headspaces[i] - 1; //Platform direkt //=nicht drunter oder drüber
		
			usedPlatform = irandom_range(1, platform_amt[newCy]);	
			
			//for(i = 0; i < platforms_len[# usedPlatform, newCy]; i++){
				//ds_grid_set(grid, platforms_start[# usedPlatform, newCy] + i, newCy - 1, WALL);
			//}
			
			ds_grid_set(grid, platforms_start[# usedPlatform, newCy], newCy - 1, WALL);
		}
		

	}//End headspace amt check
}//End height check

//////////////////////////////////////////////////////////////////////////////
//Random Blocks																//
//////////////////////////////////////////////////////////////////////////////
for(i = 0; i < 10; i++){
	cx = irandom_range(1,width-1);
	cy = irandom_range(1,height-1);
	
// ##
// ##
	
	if((grid[# cx, cy] == VOID) && (grid[# cx + 1, cy] == VOID)
		&& (grid[# cx, cy + 1] == VOID) && (grid[# cx + 1, cy + 1] == VOID)){
		
		ds_grid_set(grid, cx, cy, WALL);
		ds_grid_set(grid, cx + 1, cy, WALL);
		ds_grid_set(grid, cx, cy + 1, WALL);
		ds_grid_set(grid, cx + 1, cy + 1, WALL);
		}
}

//////////////////////////////////////////////////////////////////////////////
//Close Gaps																//
//////////////////////////////////////////////////////////////////////////////
//Set controller position to top left corner (Room boundings start pos)
var cx = 0;
var cy = 0;

//  #
// #X#
//	#

//Search for inclosed void
for(cx = 0; cx < width; cx++){
	for(cy = 0; cy < height; cy++){
		if(grid[# cx, cy] == VOID){
			if((grid[# cx + 1, cy] == WALL)
			&& (grid[# cx - 1, cy] == WALL)
			&& (grid[# cx, cy + 1] == WALL)
			&& (grid[# cx, cy - 1] == WALL)) {
				ds_grid_set(grid, cx, cy, WALL);
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////////////
//PlaceDoor																	//
//////////////////////////////////////////////////////////////////////////////
//Choose random y for the door head
cx = width - 1;
cy = irandom_range(1,height-1);

// XXD
// XXD
// ##
	
	ds_grid_set(grid, cx, cy, WALL_DOOR);
	ds_grid_set(grid, cx, cy + 1, WALL_DOOR);
	ds_grid_set(grid, cx - 1, cy, VOID);
	ds_grid_set(grid, cx - 1, cy + 1, VOID);
	ds_grid_set(grid, cx - 1, cy + 2, WALL);
	ds_grid_set(grid, cx - 2, cy, VOID);
	ds_grid_set(grid, cx - 2, cy + 1, VOID);
	ds_grid_set(grid, cx - 2, cy + 2, WALL);

//////////////////////////////////////////////////////////////////////////////
//Drawing																	//
//////////////////////////////////////////////////////////////////////////////
//Set controller position to top left corner (Room boundings start pos)
var cx = 0;
var cy = 0;

//Draw the level
for(cx = 0; cx < width; cx++){
	for(cy = 0; cy < height; cy++){
		
		if(grid[# cx, cy] == WALL){
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_solid);
		}
		else if((grid[# cx, cy] == WALL_DOOR) && (grid[# cx, cy + 1] == WALL_DOOR)){
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_brick_door);
		}
	}
}