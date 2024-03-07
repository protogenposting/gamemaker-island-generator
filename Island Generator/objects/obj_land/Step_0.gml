/// @description Insert description here
// You can write your code in this editor
var surrounded=place_meeting(x,y-8,obj_land)&&
place_meeting(x-8,y,obj_land)&&
place_meeting(x,y+8,obj_land)&&
place_meeting(x+8,y,obj_land)

if(!surrounded&&!instance_exists(obj_generator))
{
	sprite_index=spr_sand
}