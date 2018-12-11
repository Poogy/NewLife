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
cy_headspaces = array_create(99); //saves every line, which creates platforms
cy_headspaces[0] = cy;
headspace = cy_headspaces[0];
headspace_cnt = 1; //amt of lines which were created
chance_wall = 0; //Determines if a wall is likely to be placed

for(cy = 3; cy < height - 1; cy += headspace){
	if(cy + headspace < height - 1){
		headspace = irandom_range(MIN_HEADSPACE, MAX_HEADSPACE);
		cy_headspaces[headspace_cnt] = headspace;
		show_debug_message(headspace);
		headspace_cnt++;
	}
	
	for(cx = 1; cx < width - 1; cx++){

	if(cx == 2){
		if(grid[# 1, cy] == WALL){
			ds_grid_set(grid, 2, cy, WALL); //2-Walls at front
		}else if(grid[# 1, cy] == VOID){
			ds_grid_set(grid, 2, cy, VOID); //2-void at front
		}
	}else if(cx == width - 2){
		if(grid[# width - 3, cy] == WALL){
			ds_grid_set(grid, width - 2, cy, WALL); //2-Walls at end
		}else if(grid[# width - 3, cy] == VOID){
			ds_grid_set(grid, width - 2, cy, VOID); //2-void at end
		}
	}else if(cx > 1){
		if(grid[# cx - 2, cy] == VOID && grid[# cx - 1, cy] == WALL){
			ds_grid_set(grid, cx, cy, WALL); //2-Walls
		}else if(grid[# cx - 2, cy] == WALL && grid[# cx - 1, cy] == VOID){
			ds_grid_set(grid, cx, cy, VOID); //2-void
		}else if(irandom_range(1,100) <= chance_wall){ //Wall oder Void setzen
			ds_grid_set(grid, cx, cy, WALL); //Wall wins
			chance_wall -= 5;
		}else{
			ds_grid_set(grid, cx, cy, VOID); //Wall fails
			chance_wall += 5;
		}
	}else if (cx == 1){ //Erster Block pro Reihe
		if(irandom_range(0,1) == 1){ //Wall oder Void setzen
			ds_grid_set(grid, cx, cy, WALL);
			chance_wall = 90;
		}else{
			ds_grid_set(grid, cx, cy, VOID);
			chance_void = 10;
		}
	}
	}
}

//Fill in the room a bit more complex
cy = 4; //y of first inner room line drawn
cx = 0;
for(i = 1; i < height; i++){
	cy += cy_headspaces[i];
	if(cy_headspaces[i] >= 6){
		if(cy_headspaces[i] == 6){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL_SPECIAL);
		}else if(cy_headspaces[i] == 7){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL_SPECIAL);
		}else if(cy_headspaces[i] == 8){
			ds_grid_set(grid, cx, cy - cy_headspaces[i], WALL_SPECIAL);
		}
	}
}


///DRAWING
//Set controller position to top left corner (Room boundings start pos)
var cx = 0;
var cy = 0;

//Draw the level
for(cx = 0; cx < width; cx++){
	for(cy = 0; cy < height; cy++){
		if(grid[# cx, cy] == WALL){
			//Draw Tile
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_solid);
		}else if(grid[# cx, cy] == WALL_SPECIAL){
			layer_sprite_create(TILELAYER, cx * CELL_WIDTH, cy * CELL_HEIGHT, spr_solid2);
		}
	}
}