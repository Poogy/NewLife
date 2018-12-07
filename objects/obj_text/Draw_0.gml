/// @description Insert description here
// You can write your code in this editor

//Buchstaben vereinzeln
if(time < text_length){
	time += spd;
	print = string_copy(text,0,time);
}

//Render
draw_set_alpha(alpha);
if(alpha < 1) alpha += spd/10; else alpha = 1;

draw_set_font(font);
draw_set_color(c_dkgray);
draw_rectangle(x, y, x + boxwidth + (text_length / 2) * 20, y + boxheight, 0);
draw_set_color(c_black);
draw_rectangle(x, y, x + boxwidth + (text_length / 2) * 20, y + boxheight, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
/*
draw_text_ext(
	x + padding,
	y + padding,
	print,
	font_size + (font_size/2),
	maxlength
);
*/

scr_readWriteExt(text, x + padding, y + padding, font_size + (font_size/2), maxlength);

draw_set_alpha(1);