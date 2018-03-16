/// @description Insert description here
// You can write your code in this editor

//Get player input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space);

key_shoot = keyboard_check(ord("H")) || keyboard_check_pressed(vk_enter);

on_ground = place_meeting(x, y+1, oWall);

getting_hit = false;
picking_up_health = false;
getting_hit = false;


if (global.hp <= 0) {
	audio_stop_sound(sMusic);
	audio_play_sound(sDie, 1, false);
	global.dying = true;
	instance_destroy();
}


////Calculate movement
var move = key_right - key_left;

if (key_shoot) shooting_anim = 20;
else shooting_anim = max(0, shooting_anim - 1);

hsp = move * walksp;

if (abs(sign(hsp)) > 0) is_running = true;
else is_running = false;

if (on_ground && key_jump)
{
	vsp = -7;	
}
vsp = vsp + grv;


hitdelay = max(hitdelay - 1, 0);

//////Horizontal collision
if (place_meeting(x + hsp, y, oWall))
{
	while (!place_meeting(x + sign(hsp), y, oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
//if (place_meeting(x, y + vsp, oMet)) {
//	getting_hit = true;	
//	hitdelay = 15;
//}
x = x + hsp;


//////Vertical collision
if (place_meeting(x, y + vsp, oWall))
{
	while (!place_meeting(x, y + (0.01 * sign(vsp)), oWall))
	{
		y = y + (0.01 * sign(vsp));
	}
	//while (!place_meeting(x, y + (0.1 * sign(vsp)), oWall))
	//{
	//	y = y + sign(vsp);
	//}
	vsp = 0;
	on_ground =  true;
}
y = y + vsp;



//Damage detection
//if (getting_hit and hitdelay <= 0) {
//	with (oMeter) {
//		if (oMeter.image_index > 0) oMeter.image_index = oMeter.image_index - 1;	
//	}
//}

//Picking up health
if (picking_up_health) {
	with (oMeter) {
		if (oMeter.image_index < 5) oMeter.image_index = oMeter.image_index + 1;	
	}
}


//Shooting bullet creation
firingdelay = max(0, firingdelay - 1);
if (key_shoot and firingdelay == 0)
{
	firingdelay = 6;
	if image_xscale > 0 offset = 10;
	else offset = -10;
	with (instance_create_layer(x+offset,y,"shootLayer", oStar)) {
		speed = 14;
		if (other.image_xscale > 0) direction = 0;
		else direction = 180;
		audio_play_sound(sShoot, 1, false);
	}
}



//Animation
if (shooting_anim > 0) is_shooting = true;
else is_shooting = false;

on_ground = place_meeting(x, y+1, oWall);

// Player in air
if (!on_ground)
{
	// Is shooting
	if (is_shooting) {
		sprite_index = sPlayerJSh;
	} else {
		sprite_index = sPlayerJ;
	}
} else {
	if (is_running and is_shooting) {
		sprite_index = sPlayerRSh;
	} else if (!is_running and is_shooting) {
		sprite_index = sPlayerSh;
	} else if (is_running) {
		sprite_index = sPlayerR;
	} else {
		sprite_index = sPlayerSt;
	} 
}

if (sign(hsp) > 0) image_xscale = 1;
if (sign(hsp) < 0) image_xscale = -1;