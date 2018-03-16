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

//Animation

on_ground = place_meeting(x, y+1, oWall);


if (sign(hsp) > 0) image_xscale = 1;
if (sign(hsp) < 0) image_xscale = -1;