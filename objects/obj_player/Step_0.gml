/// @description Movement
// You can write your code in this editor
scr_keys();
scr_constants();
scr_check_alive();

switch(state){
	case pState.normal:
	{
			
		target = instance_nearest(x,y,obj_block2); //WIP

		hspd = (key_right - key_left)*moveSpeed;

		//Actually moving
		vspd = scr_move(hspd, vspd);
		
		//Weapons switching
		if(key_weapon_0){
			weapon = 0;
		}
		if(key_weapon_1){
			weapon = 1;
		}
		
		if(mouse_check_button_pressed(mb_left)){
			grappleX = mouse_x; //End of rope to travel
			grappleY = mouse_y;	//End of rope to travel
			ropeX = x; //Start of rope
			ropeY = y; //Start of rope
			ropeAngleVelocity = 0; //Swinging speed
			ropeAngle = point_direction(grappleX, grappleY, x, y);
			ropeLength = point_distance(grappleX, grappleY, x, y);
			state = pState.swing;
		}
	}break;
	
	case pState.swing:
	{
		var ropeAngleAcceleration = -0.2 * dcos(ropeAngle);
		ropeAngleAcceleration += (key_right - key_left) * 0.08;
		ropeLength += (key_down - key_up) * 2;
		ropeLength = max(ropeLength, 0); //Mindestgröße
		
		ropeAngleVelocity += ropeAngleAcceleration;
		ropeAngle += ropeAngleVelocity;
		ropeAngleVelocity *= 0.99; //Optional
		
		ropeX = grappleX + lengthdir_x(ropeLength, ropeAngle);
		ropeY = grappleY + lengthdir_y(ropeLength, ropeAngle);
		
		hspd = ropeX - x;
		vspd = ropeY - y;
		
		if(key_jump){
			state = pState.normal;
			vspd = -jumpSpeed;
		}
		
		vspd = scr_move(hspd, vspd);
		
	}break;
	
	case pState.transition:
	{
		
		if(aboveTrapdoor)
			y += 1;
		else { //nextToDoor
			x += 1;
		}
	}break;
}