/// @description Insert description here
// You can write your code in this editor

//Get player input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space);

key_shoot = keyboard_check(ord("H")) || keyboard_check_pressed(vk_enter);


////Calculate movement
var move = key_right - key_left;
hsp = move * walksp;
if (place_meeting(x, y+1, oWall)) && (key_jump)
{
	vsp = -4.5;	
}
vsp = vsp + grv;

//////Horizontal collision
if (place_meeting(x+hsp, y, oWall))
{
	while (!place_meeting(x+sign(hsp), y, oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

if (key_shoot) {
	
}

////Vertical collision
if (place_meeting(x, y+vsp, oWall))
{
	while (!place_meeting(x, y + sign(vsp), oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

//Shooting bullet creation
firingdelay = firingdelay - 1;
if (key_shoot && firingdelay < 0)
{
	firingdelay = 4;
	if image_xscale > 0 offset = 10;
	else offset = -10;
	with (instance_create_layer(x+offset,y,"shootLayer", oStar)) {
		speed = 15;
		if (other.image_xscale > 0) direction = 0;
		else direction = 180;
	}
}



//Animation
if (key_shoot) shooting_anim = 20;
else shooting_anim = max(0, shooting_anim - 1);


// Player in air
if (!place_meeting (x, y+1, oWall))
{
	// Is shooting
	if (shooting_anim > 0) {
		image_speed = 0;
		sprite_index = sPlayerJSh;
	} else {
		sprite_index = sPlayerJ;
	}
} else {
	if (shooting_anim > 0) {
		sprite_index = sPlayerSh;
	} else if (abs(sign(hsp)) > 0) {
		image_speed = 1;
		sprite_index = sPlayerR;
	} else {
		sprite_index = sPlayerSt;
	} 
}

if (sign(hsp) > 0) image_xscale = 1;
if (sign(hsp) < 0) image_xscale = -1;