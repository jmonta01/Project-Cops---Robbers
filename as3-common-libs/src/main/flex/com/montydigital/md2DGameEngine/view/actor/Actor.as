package com.montydigital.md2DGameEngine.view.actor
{
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	
	import flash.geom.Point;
	
	public class Actor extends AbstractProp implements IActor
	{
		public function Actor(width:Number, height:Number, position:Point)
		{
			super(width, height, position);
		}
	}
}