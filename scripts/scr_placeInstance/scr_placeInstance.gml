///scr_placeEnemy(amt, ins);
amt = argument0;
ins = argument1;

randX = irandom_range(32, WIDTH - 32);
randY = irandom_range(32, HEIGHT - 32);

for(i = 0; i < amt; i++) {
	instances[i] = instance_create_depth(randX, randY, 0, ins);
	with instances[i] { 
		do {
			x = irandom_range(32, room_width - 32);
			y = irandom_range(32, room_height - 32);
		} until (!place_meeting(x, y, obj_solid));
	}
}