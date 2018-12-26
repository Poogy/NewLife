/// @description Gun
// You can write your code in this editor
draw_self();

//EXÜERIMENTAL
//Shooting
draw_text(390,100,vspd);

if(attack_rdy == true){
	if(key_aim_up && !key_aim_right && !key_aim_down && !key_aim_left){ //Up
		attack_rdy = false;
		alarm_set(0,obj_weapon_controller.weapon[weapon,8]);
		dir = 1;
		if(weapon != 0){
			draw_sprite_ext(spr_gun,0,x+sprite_width/2,y+sprite_height/2,1,1,90,c_white,1);
		}
		instance_create_depth(x+sprite_width/2,y-obj_weapon_controller.weapon[weapon,7],0,obj_weapon_controller.weapon[weapon,5]);
	}
	
	if(!key_aim_up && key_aim_right && !key_aim_down && !key_aim_left){ //Right
		attack_rdy = false;
		alarm_set(0,obj_weapon_controller.weapon[weapon,8]);
		dir = 0;
		if(weapon != 0){
			draw_sprite_ext(spr_gun,0,x+sprite_width/2,y+sprite_height/2,1,1,0,c_white,1);
		}
		instance_create_depth(x+sprite_width+obj_weapon_controller.weapon[weapon,7],y+sprite_height/2,0,obj_weapon_controller.weapon[weapon,5]);
	}
		
	if(!key_aim_up && !key_aim_right && key_aim_down && !key_aim_left){ //Down
		attack_rdy = false;
		alarm_set(0,obj_weapon_controller.weapon[weapon,8]);
		dir = 3;
		if(weapon != 0){
			draw_sprite_ext(spr_gun,0,x+sprite_width/2,y+sprite_height/2,1,1,270,c_white,1);
		}
		instance_create_depth(x+sprite_width/2,y+sprite_height+obj_weapon_controller.weapon[weapon,7],0,obj_weapon_controller.weapon[weapon,5]);
	}
		
	if(!key_aim_up && !key_aim_right && !key_aim_down && key_aim_left){ //Left
		attack_rdy = false;
		alarm_set(0,obj_weapon_controller.weapon[weapon,8]);
		dir = 2;
		if(weapon != 0){
			draw_sprite_ext(spr_gun,0,x+sprite_width/2,y+sprite_height/2,1,1,180,c_white,1);
		}
		instance_create_depth(x-obj_weapon_controller.weapon[weapon,7],y+sprite_height/2,0,obj_weapon_controller.weapon[weapon,5]);
	}
}

//DRAWING CURRENT WEAPON
draw_sprite(obj_weapon_controller.weapon[weapon,1],0,100,30);

//ROPE SWINING
draw_set_color(c_white);
if(state == pState.swing) draw_line_width(grappleX, grappleY, ropeX, ropeY, 2);

//Go into cave
if(aboveTrapdoor || nextToDoor){
	draw_roundrect_color_ext(x - 64, y - 64, x + 64, y - 16, 30, 30, c_purple, c_purple, false);
	draw_set_color(c_black);
	draw_roundrect_color_ext(x - 64, y - 64, x + 64, y - 16, 30, 30, c_black, c_black, true);
	prev_font = draw_get_font();
	draw_set_font(fnt_sign);
	draw_text(x - 48, y - 48, "Press ENTER to go \n into the cave");
	draw_set_font(prev_font);
	
	if(key_accept){
		state = pState.transition;
	}
}