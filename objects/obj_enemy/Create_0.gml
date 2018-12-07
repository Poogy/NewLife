/// @description Stats
// You can write your code in this editor
state = states.idle;
image_index = 0;
rangeOfSight = 96;

spd = .5;
hspd = 0;
vspd = 0;
grav = 0.2;
moveSpeed = 2;
hp = 3;
hpMax = hp;

friendly = false; //Verbündet
passive = true; //Wont attack/follow if you use fists
hostile = false; //Will attack you if your in RangeOfSight
aggressive = false; //Will hunt you down no matter what