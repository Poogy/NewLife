///scr_placeBox();
scr_basic();

for(r = 0; r < rows; r++){
	instance_create_depth(16 + 32 * r, 16, 0, obj_solid); //Upper Row
	instance_create_depth(16 + 32 * r, HEIGHT - 16, 0, obj_solid); //Lower Row
}

for(c = 1; c < columns - 1; c++){
	instance_create_depth(16, 16 + 32 * c, 0, obj_solid); //Left Column
	instance_create_depth(WIDTH - 16, 16 + 32 * c, 0, obj_solid); //Right Column
}