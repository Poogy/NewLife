/// @description Insert description here

if(instance_exists(obj_player)){
	if(room == rm_cave){
		draw_roundrect_color_ext(16, 16, 192, 120, 30, 30, c_purple, c_purple, false);
		draw_set_color(c_black);
		draw_roundrect_color_ext(16, 16, 192, 120, 30, 30, c_black, c_black, true);
		draw_text(32, 32, "HP: " + string(obj_player.hp));
		draw_text(32, 48, "Enemies left: " + string(instance_number(obj_enemy)));
		draw_text(32, 64 , obj_system.time/60);
		if(stage == -1){
			draw_text(32, 80 , "Stage: 0");
		}else{
			draw_text(32, 80 , "Stage: " + string(stage));
		}
	}
}else{
	
	if(a != 100 && wait && firstCycle){
		alarm_set(0, 2);
		wait = false;
	}
	
	if(a == 100 && firstCycle){
		firstCycle = false;
		if(room == rm_town){
			room_goto(rm_cave);
		}else if(room == rm_cave){
			
			room_restart();
			show_debug_message("Restart!");
		}
	}
	
	if(a <= 100 && a >= 0 && wait && !firstCycle){
		alarm_set(0, 2);
		wait = false;
		if(room == rm_cave){
			a = 0;
		}
	}
	
	if(a == 0 && !firstCycle){ //End of transition/cave restart
		firstCycle = true;
		if(room == rm_cave){
			stage++;
		}
	}
	
	draw_set_alpha(a/100);
	draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
	
	
	//draw_set_color(c_red);
	//draw_set_halign(fa_center);
	//draw_set_valign(fa_center);
	//draw_text(1920/2 - room_width/4, room_height/2, "GAME OVER");
}

draw_set_alpha(1);