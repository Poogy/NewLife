/// @description Insert description here
// You can write your code in this editor
application_surface_draw_enable(false);
window_set_fullscreen(true);
global.MonitorW=display_get_width();
global.MonitorH=display_get_height();
global.Xoffset=(global.MonitorW-640)/2;
global.Yoffset=(global.MonitorH-360)/2;

if(global.MonitorW>=1920 && global.MonitorH>=1080){
surface_resize(application_surface,1920,1080)
global.Xoffset=(global.MonitorW-1920)/2;
global.Yoffset=(global.MonitorH-1080)/2;
}

//Spawn every other needed controller_obj
instance_create_depth(0,0,0,obj_lang);
instance_create_depth(0,0,0,obj_weapon_controller);
instance_create_depth(0,0,0,obj_gui);

//start timer
time = 0;