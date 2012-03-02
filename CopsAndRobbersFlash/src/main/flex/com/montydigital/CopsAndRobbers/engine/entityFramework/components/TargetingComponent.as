package com.montydigital.CopsAndRobbers.engine.entityFramework.components{
	import starling.display.StDisplayObject;
	
	public class TargetingComponent{
		
		public var crossHairsDisplayComponent:DisplayComponent;
		public var crossHairsPositionComponent:PositionComponent;
		
		public var x:Number=0;
		public var y:Number=0;
		public var firing:Boolean = false;

	}
}