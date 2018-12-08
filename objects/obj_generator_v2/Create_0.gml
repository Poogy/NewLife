/// @description Insert description here
// You can write your code in this editor

//Constants
scr_constants();

//Randomize
randomize();

//Room size
room_width = (CELL_WIDTH/16) * 720;
room_width = (CELL_HEIGHT/16) * 720;

//Set the grid width and height - Wie viele Objekte in den Raum passen
var width = room_width div CELL_WIDTH;
var height = room_height div CELL_HEIGHT;

//Create grid
grid = ds_grid_create(width, height);

//Fill the grid with void
ds_grid_set_region(grid, 0, 0, width - 1, height - 1, VOID);

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

//Clamp - don´t move out of bounds
cx = clamp(cx, 1, width -1);
cy = clamp(cy, 1, height -1);

//Set controller position to top left corner (Inner room start pos)
var cx = 1;
var cy = 3; //3 Because of headspace on the upper platform

for(cy = 3; cy < height - 1; cy += headspace){
	headspace = irandom_range(MIN_HEADSPACE, MAX_HEADSPACE);	
	for(cx = 1; cx < width - 1; cx++){

	if(grid[# cx - 2, cy] == WALL && grid[# cx - 1, cy] == VOID){
		ds_grid_set(grid, cx, cy, VOID);
	}
		
	
		if(irandom_range(0,1) == 1){
			ds_grid_set(grid, cx, cy, WALL);
		}else{
			ds_grid_set(grid, cx, cy, VOID);
		}
	}
}

//Set controller position to top left corner (Room boundings start pos)
var cx = 0;
var cy = 0;

//Draw the level
for(cx = 0; cx < width; cx++){
	for(cy = 0; cy < height; cy++){
		if(grid[# cx, cy] == WALL){
			//Draw Tile
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_solid);
		}
	}
}

