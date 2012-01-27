package com.montydigital.md2DGameEngine.view.abstract.starling
{
	import flash.geom.Point;
	
	import starling.display.StDisplayObject;

	public interface IAbstractStarlingItem
	{
		function get stItem():StDisplayObject;
		function set stItem(val:StDisplayObject):void;
		function updatePosition(position:Point, rot:Number):void;
	}
}