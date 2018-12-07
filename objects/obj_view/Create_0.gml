/// @description Insert description here
// You can write your code in this editor
smooth = 0.5;
zoom = 1.5;

view_set_wport(view_current, view_wport[view_current] * zoom);
view_set_hport(view_current, view_hport[view_current] * zoom);

display_set_gui_size(view_wport[view_current], view_hport[view_current]);