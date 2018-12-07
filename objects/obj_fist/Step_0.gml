/// @description Place to be
// You can write your code in this editor
if(instance_exists(obj_player)){
	switch(dir){
		case 0: //Right
			x = obj_player.x + 32 + sprite_width/2;
			y = obj_player.y + 16;
			break;
		case 1: //Up
			x = obj_player.x + 16;
			y = obj_player.y - sprite_height/2;
			break;
		case 2: //Left
			x = obj_player.x - sprite_width/2;
			y = obj_player.y + 16;
			break;
		case 3: //Down
			x = obj_player.x + 16;
			y = obj_player.y + 32 + sprite_height/2;
			break;
	}
}else instance_destroy();