package com.montydigital.CopsAndRobbers.engine.entityFramework.components
{
	import starling.display.StDisplayObject;

	public class DisplayComponent{
		public var layer:int;
		public var displayObject:StDisplayObject;		
		public var visible:Boolean = true;
		public var added:Boolean = false;
		
		public var hasTimeout:Boolean=false;
		public var timeRemaining:int;
		
		public function DisplayComponent()
		{
		}
	}
}