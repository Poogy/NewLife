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