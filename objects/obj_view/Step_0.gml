/// @description Insert description here
// You can write your code in this editor
x = floor(x);
y = floor(y);

if(instance_exists(obj_player)){
	//Set view to player
	if(distance_to_object(obj_player) > 2) {
		x += (obj_player.x - x) * smooth;
		y += (obj_player.y - y) * smooth;
	}else{
		x = obj_player.x;
		y = obj_player.y;
	}
}