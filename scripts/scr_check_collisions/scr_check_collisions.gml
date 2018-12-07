//Ground collision
if((place_meeting(x,y+1,obj_solid))){
	vspd = 0;
	
	//Got chance to jump
	if(instance_exists(obj_player) && obj_player.key_up && obj_player.vspd == 0){ //billiger fix vspd
			with obj_player vspd -= jumpSpeed; //Jump
	}

}else{
	
	//Gravity
	if(self.vspd < 10){
		self.vspd += grav;
	}
}

//Horizontal
if((place_meeting(x+hspd,y,obj_solid))){
	while(!place_meeting(x+sign(hspd),y,obj_solid)){
		x += sign(hspd);
	}
	hspd = 0;
}

//Move Horizontal
x += hspd;

//Vertical
if((place_meeting(x,y+vspd,obj_solid))){
	while(!place_meeting(x,y+sign(vspd),obj_solid)){
		y += sign(vspd);
	}
	vspd = 0;
}

//Move Vertical
y += vspd;