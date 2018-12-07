/// @description Physics
// You can write your code in this editor

scr_check_alive();
scr_check_collisions();

if(instance_exists(obj_player)){
	if(attack_rdy){
		if(state == states.attack){
			attack_rdy = false;
			alarm_set(0,60);
			pd = point_direction(x+16,y+16,obj_player.x+16,obj_player.y+16)
			dir = angle_difference(random_range(-5,5),-pd);
			instance_create_depth(x+16,y+16,0,obj_bullet_enemy);
		}
	}
}else{
	attack_rdy = false;
	pd = 0;
}