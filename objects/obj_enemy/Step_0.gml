/// @description Physics
// You can write your code in this editor

scr_check_alive();
scr_check_collisions();

if(instance_exists(obj_player)){
	if(state == states.chase){
		if(x > obj_player.x){
			hspd = -spd;
		}else if(x < obj_player.x){
			hspd = spd;
		}
	}else if(state == states.idle){
		hspd = 0;
	}
}else{
	state = states.idle;
	hspd = 0;
	image_index = 0;
}