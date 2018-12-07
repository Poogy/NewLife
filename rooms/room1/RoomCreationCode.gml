randomize();

room_speed = 60;
instance_create_depth(0,0,0,obj_generator);

instance_create_depth(0,0,0,obj_system);
instance_create_depth(0,0,0,obj_view);
instance_create_depth(0,0,0,obj_lang);
instance_create_depth(0,0,0,obj_weapon_controller);
instance_create_depth(0,0,0,obj_gui);

instance_create_depth(64,64,0,obj_player);