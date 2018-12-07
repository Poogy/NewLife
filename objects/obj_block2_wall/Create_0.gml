/// @description Insert description here
// You can write your code in this editor
image_speed = 0;

var block2 = instance_nearest(x,y,obj_block2);
var block2_wall = instance_nearest(x,y,obj_block2_wall);

if(block2.x < x+64 && block2.y == y){
	image_index = 0;
}else if(block2_wall.x < x+64 && block2_wall.y == y){
	image_index = 1;
}