text = argument0;
write_x = argument1;
write_y = argument2;
sep = argument3;
w = argument4;

length = string_length(text);
space_amt = 0;

for(j = 0; j < length; j++){
	
	letters[j] = string_copy(text,j+1,1);
	
	if(letters[j] == " ") space_amt += 1;
	
	for(k = 0; k < 30; k++){
		for(i = 0; i < 2; i++){
			if(letters[j] == obj_lang.lang_letter[k,i]){
				if(obj_lang.lang_known[k] == true){
					draw_set_font(fnt_known);
					draw_text_ext(write_x + 20 * j,write_y,letters[j],sep,w);
				}else{
					draw_set_font(fnt_unknown);
					draw_text_ext(write_x + 20 * j,write_y,letters[j],sep,w);
				}
			}
		}
	}
}
show_message(space_amt);

draw_set_font(fnt_known);