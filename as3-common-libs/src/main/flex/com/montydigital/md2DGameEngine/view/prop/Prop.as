package com.montydigital.md2DGameEngine.view.prop{
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	import flash.geom.Point;	
	
	public class Prop extends AbstractProp implements IProp{
		public function Prop(width:Number, height:Number, position:Point){
			super(width, height, position);
		}
	}
}