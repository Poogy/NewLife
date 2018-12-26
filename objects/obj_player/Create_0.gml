/// @description Stats
// You can write your code in this editor
dir = 0;
hspd = 0;
vspd = 0;
grav = 0.2;
moveSpeed = 2;
jumpSpeed = 5;

hp = 4;

weapon = 0;
attack_rdy = true;

enum pState
{
	normal,
	swing,
	transition
}

state = pState.normal;


//Places to be
aboveTrapdoor = false;
nextToDoor = false;