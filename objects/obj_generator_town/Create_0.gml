/// @description Insert description here
// You can write your code in this editor

//Constants
scr_constants();

//Randomize
randomize();

//Room size
room_width = (CELL_WIDTH/16) * 360;
room_height = (CELL_HEIGHT/16) * 180;

//Set the grid width and height - Wie viele Objekte in den Raum passen
var width = room_width div CELL_WIDTH;
var height = room_height div CELL_HEIGHT;

//Create grids
grid = ds_grid_create(width, height);

//Fill the grids with void
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


ds_grid_set(grid, 1, 8, WALL);
ds_grid_set(grid, 2, 8, WALL);
ds_grid_set(grid, 3, 8, WALL);

ds_grid_set(grid, 1, 6, WALL_PORTAL);
ds_grid_set(grid, 1, 7, WALL_PORTAL);
ds_grid_set(grid, 2, 6, WALL_PORTAL);
ds_grid_set(grid, 2, 7, WALL_PORTAL);

ds_grid_set(grid, 14, 10, WALL_TRAPDOOR);

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
		else if((grid[# cx, cy] == WALL_PORTAL) && (grid[# cx + 1, cy] == WALL_PORTAL) &&
		   (grid[# cx, cy + 1] == WALL_PORTAL) && (grid[# cx + 1, cy + 1] == WALL_PORTAL)){
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_brick_portal);
		}
		else if(grid[# cx, cy] == WALL_TRAPDOOR){
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_trapdoor_wall);
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, (cy - 1) * CELL_HEIGHT, spr_trapdoor);
		}
	}
}