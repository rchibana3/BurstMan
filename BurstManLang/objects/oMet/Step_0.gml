/// @description Insert description here
// You can write your code in this editor

//Cycle of sit, emerge, shoot, move.
//Sits x frames, emerge, shoot, scoots forward for y frames. Back to sit.
//Turns around if running into a wall.

on_ground = place_meeting(x, y+1, oWall);

getting_hit = false;
picking_up_health = false;

if (hp == 0) instance_destroy();

////Calculate movement

if (is_shooting) shooting_anim = 20;
else shooting_anim = max(0, shooting_anim - 1);


vsp = vsp + grv;


if (is_moving) hsp = walksp * image_xscale;
else hsp = 0;

//////Horizontal collision
if (place_meeting(x + hsp, y, oWall))
{
	image_xscale = -image_xscale;
	hsp = -hsp;
}
x = x + hsp;



//////Vertical collision
if (place_meeting(x, y + vsp, oWall))
{
	while (!place_meeting(x, y + sign(vsp), oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
	on_ground = true;
}
y = y + vsp;



//Damage detection
if (getting_hit) {
	with (oMeter) {
		if (image_index > 0) image_index = image_index - 1;	
	}
}

//Picking up health
if (picking_up_health) {
	with (oMeter) {
		if (image_index < 5) image_index = image_index + 1;	
	}
}


//Shooting bullet creation
firingdelay = max(0, firingdelay - 1);
if (is_shooting and firingdelay == 0)
{
	firingdelay = 10;
	if image_xscale > 0 offset = 10;
	else offset = -10;
	with (instance_create_layer(x+offset,y,"shootLayer", oBullet)) {
		speed = 8;
		if (other.image_xscale > 0) direction = 0;
		else direction = 180;
		audio_play_sound(sShoot, 1, false);
	}
}



//Animation
if (shooting_anim > 0) is_shooting = true;
else is_shooting = false;

on_ground = place_meeting(x, y+1, oWall);


moving_tick = max(0, moving_tick-1);
sitting_tick = max(0, sitting_tick-1);
emerging_tick = max(0, emerging_tick-1);
shooting_tick = max(0, shooting_tick-1);


// Cycle
if (is_sitting) {
	image_index = 0;
	if (sitting_tick <= 0) {
		is_sitting = false;
		emerging_tick = EMERGING_TICK_MAX;
		is_emerging = true;
	}
}
else if (is_emerging) {
	if (emerging_tick > (SHOOTING_TICK_MAX / 2)) image_index = 1;
	else image_index = 2;
	if (emerging_tick <= 0) {
		is_emerging = false;
		shooting_tick = SHOOTING_TICK_MAX;
		is_shooting = true;
	}
}
else if (is_shooting) {
	image_index = 2;
	if (shooting_tick <= 0) {
		is_shooting = false;
		moving_tick = MOVING_TICK_MAX;
		is_moving = true;
		moving_iteration = MOVING_ITERATIONS;
	}
}
else if (is_moving) {
	if (moving_iteration > 0) {
		if (moving_tick <= 0) {
			moving_iteration = moving_iteration-1;
			moving_tick = MOVING_TICK_MAX;
			// Cycle between indices 3 and 4
			image_index = ((image_index + 1) % 2) + 3;
		}
	} else {
		is_moving = false;
		sitting_tick = SITTING_TICK_MAX;
		is_sitting = true;
	}
}

if (sign(hsp) > 0) image_xscale = 1;
if (sign(hsp) < 0) image_xscale = -1;