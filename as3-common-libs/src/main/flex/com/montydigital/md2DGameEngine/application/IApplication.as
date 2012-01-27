package com.montydigital.md2DGameEngine.application
{
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import starling.core.Starling;
	import starling.display.StSprite;

	public interface IApplication
	{
		function get starling():Starling
		function set starling(val:Starling):void;
		
		function get mdWorld():MDWorld;
		function set mdWorld(val:MDWorld):void;
		
		function get rootStarlingSprite():StSprite;
		function set rootStarlingSprite(val:StSprite):void;
	}
}