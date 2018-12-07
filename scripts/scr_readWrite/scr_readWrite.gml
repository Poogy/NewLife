text = argument0;
write_x = argument1;
write_y = argument2;

length = string_length(text);

for(j = 0; j < length; j++){
	
	letters[j] = string_copy(text,j+1,1);
	
	for(k = 0; k < 30; k++){
		for(i = 0; i < 2; i++){
			if(letters[j] == obj_lang.lang_letter[k,i]){
				if(obj_lang.lang_known[k] == true){
					draw_set_font(fnt_known);
					draw_text(write_x + 20 * j,write_y,letters[j]);
				}else{
					draw_set_font(fnt_unknown);
					draw_text(write_x + 20 * j,write_y,letters[j]);
				}
			}
		}
	}
}

draw_set_font(fnt_known);