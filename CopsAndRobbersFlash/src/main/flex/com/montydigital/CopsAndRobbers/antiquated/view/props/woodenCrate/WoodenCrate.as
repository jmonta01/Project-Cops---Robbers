package com.montydigital.CopsAndRobbers.antiquated.view.props.woodenCrate
{
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	
	import flash.geom.Point;
	
	import starling.textures.Texture;
	
	public class WoodenCrate extends DestructibleProp
	{
		public function WoodenCrate(width:Number, height:Number, position:Point, frames:Vector.<Texture>, parts:Vector.<DestructibleProp>)
		{
			super(width, height, position, frames, parts);
		}
	}
}