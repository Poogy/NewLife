///scr_placeEnemy(amt);
amt = argument0;

randX = irandom_range(32, WIDTH - 32);
randY = irandom_range(32, HEIGHT - 32);

for(i = 0; i < amt; i++) {
	enemies[i] = instance_create_depth(randX, randY, 0, obj_enemy);
	with enemies[i] { 
		do {
			x = irandom_range(32, room_width - 32);
			y = irandom_range(32, room_height - 32);
		} until (!place_meeting(x, y, obj_solid));
	}
}