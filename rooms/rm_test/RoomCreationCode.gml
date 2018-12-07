room_speed = 60;
instance_create_depth(0,0,0,obj_system);
instance_create_depth(0,0,0,obj_view);
instance_create_depth(0,0,0,obj_lang);
instance_create_depth(0,0,0,obj_weapon_controller);
instance_create_depth(0,0,0,obj_gui);

enum states{
	idle,
	chase,
	attack
}

scr_text("Dando suckt harte Dicks am Stadtrand", 0.5, 100, 485);