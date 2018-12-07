/// @description Movement
// You can write your code in this editor
scr_keys()

target = instance_nearest(x,y,obj_block2);

scr_check_alive();
scr_check_collisions();

//Movement
//Right
if(key_right){
	hspd = moveSpeed;
}

//Left
if(key_left){
	hspd = -moveSpeed;
}

//Player should stand still
if((!key_right && !key_left) || (key_right && key_left)){
	hspd = 0;
}

//WEAPONS
if(key_weapon_0){
	weapon = 0;
}
if(key_weapon_1){
	weapon = 1;
}

//TOOLS
if(key_tool){
	
}