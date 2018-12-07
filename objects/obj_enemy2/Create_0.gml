/// @description Stats
// You can write your code in this editor
state = states.attack;
image_index = 0;
rangeOfSight = 3000;

spd = .5;
hspd = 0;
vspd = 0;
grav = 0.2;
moveSpeed = 2;
hp = 5;
hpMax = hp;

attack_rdy = true;

friendly = false; //Verbündet
passive = false; //Wont attack/follow if you use fists
hostile = false; //Will attack you if your in RangeOfSight
aggressive = true; //Will hunt you down no matter what