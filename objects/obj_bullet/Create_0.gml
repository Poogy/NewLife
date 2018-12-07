/// @description Destination
// You can write your code in this editor
dir = obj_player.dir;
spd = obj_weapon_controller.weapon[obj_player.weapon,3];
spdMax = obj_weapon_controller.weapon[obj_player.weapon,4];
alarm_set(0, obj_weapon_controller.weapon[obj_player.weapon,6]);
dmg = obj_weapon_controller.weapon[obj_player.weapon,4];