/// @description 
randomize()

currentIteration=0

amountOfIterations=50

initialNodes=800

nodeKillChance=33

reproductionAmount=2

overpopulationCount=4

#region create the basic nodes
repeat(initialNodes)
{
	var _inst=instance_create_depth(irandom(room_width),irandom(room_height),depth,obj_land)
	with(_inst)
	{
		while(distance_to_object(obj_land)<=8)
		{
			x=irandom(room_width)
			y=irandom(room_height)
			move_snap(16,16)
		}
		move_snap(16,16)
	}
}
#endregion
/// @description      This function makes islands create more land and stuff like that.
function iterate_islands(){
	#region cellular automina (idk how to spell it :3)
	for(var i=0;i<instance_number(obj_land);i++)
	{
		var _inst=instance_find(obj_land,i)
		with(_inst)
		{
			var _list = ds_list_create();
			var neighborCount = collision_rectangle_list(x - 16, y - 16, x + 16, y + 16, obj_land, false, true, _list, false);
			ds_list_destroy(_list);
			if(neighborCount<other.reproductionAmount)
			{
				var _inst2=instance_create_depth(x+choose(-16,0,16),y+choose(-16,0,16),depth,obj_land)
				while(_inst2.x==x&&_inst2==y)
				{
					x=choose(-16,0,16)
					y=choose(-16,0,16)
				}
			}
			else if(neighborCount>other.overpopulationCount)
			{
				instance_destroy()
			}
			else if(irandom(100)<other.nodeKillChance)
			{
				instance_destroy()
			}
		}
	}
	#endregion
	with(obj_land)
	{
		if(x<0||x>room_width||y<0||y>room_height)
		{
			instance_destroy()
		}
	}
	currentIteration++
}

/// @description             Cleans up the shapes of islands so they look more smooth and like actual islands.
function make_islands(){
	#region get empty space
	var _islandList=[]
	var _x=0
	repeat(room_width/16)
	{
		var _y=0
		repeat(room_height/16)
		{
			if(!collision_point(_x,_y,obj_land,true,true))
			{
				array_push(_islandList,{x: _x,y: _y})
			}
			_y+=16
		}
		_x+=16
	}
	#endregion
	#region smooth islands
	for(var i=0;i<array_length(_islandList);i++)
	{
		var _list = ds_list_create();
		var neighborCount = collision_rectangle_list(_islandList[i].x-16,_islandList[i].y-16,_islandList[i].x+16,_islandList[i].y+16, obj_land, false, true, _list, false);
		ds_list_destroy(_list);
		if(neighborCount>4)
		{
			instance_create_depth(_islandList[i].x,_islandList[i].y,depth,obj_land)
		}
	}
	#endregion
}

/// @description            Removes stray islands to make them all cleaner
/// @param {Real}     cleanupAmount    The amount of times the cleanup script will run
function island_cleanup(cleanupAmount){
	while(cleanupAmount>0)
	{
		with(obj_land)
		{
			var _list = ds_list_create();
			var neighborCount = collision_rectangle_list(x - 16, y - 16, x + 16, y + 16, obj_land, false, true, _list, false);
			ds_list_destroy(_list);
			if(neighborCount<3)
			{
				instance_destroy()
			}
		}
		cleanupAmount--
	}
}