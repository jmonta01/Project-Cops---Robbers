package com.montydigital.md2DGameEngine.vo.box2d
{
	import com.montydigital.common.vo.IValueObject;
	
	import flash.geom.Point;

	public class Box2DItemInitialCoords implements IValueObject
	{
		public var position:Point;
		public var angle:Number;
		
		public function Box2DItemInitialCoords(x:Number, y:Number, angle:Number=0)
		{
			this.position = new Point(x, y);
			this.angle = angle;
		}
	}
}