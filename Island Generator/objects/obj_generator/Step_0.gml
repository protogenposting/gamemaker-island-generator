/// @description 
if(currentIteration<amountOfIterations)
{
	iterate_islands()
}
else
{
	make_islands()
	island_cleanup(15)
	instance_destroy()
}