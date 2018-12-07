/// @description Check Range Of Sight
// You can write your code in this editor
draw_self();

if(instance_exists(obj_player)){
	dif_x = obj_player.x - x;
	if(dif_x < 0){
	dif_x *= -1;	
	}

	dif_y = obj_player.y - y;
	if(dif_y < 0){
	dif_y *= -1;	
	}
}


if(dif_x < rangeOfSight && dif_y < rangeOfSight){
	image_index = 1;
	state = states.attack;
}else{
	image_index = 0;
	state = states.attack;
}

//Draw Healthbar
preColor = draw_get_color();
draw_set_color(c_black);
draw_rectangle(x - sprite_width/4 - 1, y - sprite_width/3 - 1, x + sprite_width + sprite_width/4 + 1, y - sprite_width/10 + 1, false);
draw_set_color(c_red);
draw_rectangle(x - sprite_width/4, y - sprite_width/3, (x - sprite_width/4) + (sprite_width/2 + sprite_width) * (hp/hpMax), y - sprite_width/10, false);
draw_set_color(preColor);