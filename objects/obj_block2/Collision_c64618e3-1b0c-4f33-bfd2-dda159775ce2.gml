/// @description Get Damaged
// You can write your code in this editor
if(image_amt-1 > image_index){
	image_index += 1;
}else{
	respawn = instance_create_depth(x,y,0,obj_respawn_controller);
	instance_destroy();
}
