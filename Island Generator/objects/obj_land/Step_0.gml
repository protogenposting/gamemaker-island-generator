/// @description 

var surrounded=place_meeting(x,y-1,obj_land)&&
place_meeting(x-1,y,obj_land)&&
place_meeting(x,y+1,obj_land)&&
place_meeting(x+1,y,obj_land)

//change sprite if surrounded :3
if(!surrounded&&!instance_exists(obj_generator))
{
	sprite_index=spr_sand
}