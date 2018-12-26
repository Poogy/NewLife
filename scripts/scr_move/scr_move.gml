///scr_move(hspd, vspd);
var hspd = argument0;
var vspd = argument1;

//Horizontal collisions
if(scr_grid_place_meeting(x + (hspd), y)){
	state = pState.normal;
	while (!scr_grid_place_meeting(x + sign(hspd), y)){
		x += sign(hspd);
		
		if(state == pState.swing){
			ropeAngle = point_direction(grappleX, grappleY, x, y);
			ropeVelocity = 0;
			state = pState.normal;
		}
	}
		hspd = 0;
}

//Move horizontally
x += hspd;

//Vertical collisions
if(scr_grid_place_meeting(x, y + (vspd))){
	state = pState.normal;
	while (!scr_grid_place_meeting(x, y + sign(vspd))){
		y += sign(vspd);
		
		if(state == pState.swing){
			ropeAngle = point_direction(grappleX, grappleY, x, y);
			ropeVelocity = 0;
			state = pState.normal;
		}
	}
		vspd = 0;
}

//Ground collision
if((scr_grid_place_meeting(x, y + 1))){
	vspd = 0;
	
	//Got chance to jump
	if(instance_exists(obj_player) && obj_player.key_jump && vspd == 0){ //billiger fix vspd
			with obj_player vspd -= jumpSpeed; //Jump
	}

}else{
	
	//Gravity kicks in
	if(vspd < 10){
		vspd += grav;
	}
}

//Move vertically
y += vspd;

//So grav can increment (vspd is not set by keys, unlike hspd <- obj_player.step)
return vspd;