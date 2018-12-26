///scr_grid_place_meeting(x, y);
var xx = argument0;
var yy = argument1;

//Remember our position
var xp = x;
var yp = y;

//Update the position for the bbox calculations
x = xx;
y = yy;

if (room = rm_town) var collisionGrid = obj_generator_town.grid;
if (room = rm_cave) var collisionGrid = obj_generator_v2.grid;

//Check for x meeting
var x_meeting = (collisionGrid[# bbox_right div CELL_WIDTH, bbox_top div CELL_HEIGHT] != VOID) ||
				(collisionGrid[# bbox_left div CELL_WIDTH, bbox_top div CELL_HEIGHT] != VOID);
				
//Check fo y meeting
var y_meeting = (collisionGrid[# bbox_right div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] != VOID) ||
				(collisionGrid[# bbox_left div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] != VOID);
				
//Check center for extra safety
var center_meeting = collisionGrid[# xx div CELL_WIDTH, yy div CELL_HEIGHT] != VOID;	
				
//Check if standing above a trapdoor				
var trapdoor_meeting = (collisionGrid[# bbox_right div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] == WALL_TRAPDOOR) ||
					   (collisionGrid[# bbox_left div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] == WALL_TRAPDOOR);

//Check for x meeting with a door
var x_meeting_door = (collisionGrid[# bbox_right div CELL_WIDTH, bbox_top div CELL_HEIGHT] == WALL_DOOR) ||
				(collisionGrid[# bbox_left div CELL_WIDTH, bbox_top div CELL_HEIGHT] == WALL_DOOR);
				
//Check fo y meeting with a door
var y_meeting_door = (collisionGrid[# bbox_right div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] == WALL_DOOR) ||
				(collisionGrid[# bbox_left div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] == WALL_DOOR);
				
//Move back
x = xp;
y = yp;

//Above Trapdoor?
obj_player.aboveTrapdoor = trapdoor_meeting;

//Touching a door?
obj_player.nextToDoor = x_meeting_door || y_meeting_door;

//Return boolean
return x_meeting || y_meeting || center_meeting;