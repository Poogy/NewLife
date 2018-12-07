/// @description Insert description here

if(instance_exists(obj_player)){
	draw_roundrect_color_ext(16, 16, 192, 80, 30, 30, c_purple, c_purple, false);
	draw_set_color(c_black);
	draw_roundrect_color_ext(16, 16, 192, 80, 30, 30, c_black, c_black, true);
	draw_text(32, 32, "HP: " + string(obj_player.hp));
	draw_text(32, 48, "Enemies left: " + string(instance_number(obj_enemy)));
}else{
	
	if(a != 100 && wait){
		alarm_set(0, 2);
		wait = false;
	}
	
	draw_set_alpha(a/100);
	draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
	draw_set_color(c_red);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(1920/2 - room_width/4, room_height/2, "GAME OVER");
}

draw_set_alpha(1);