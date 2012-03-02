package com.montydigital.CopsAndRobbers.events.levelEnded{
	import starling.events.StEvent;
	
	public class LevelEndedEvent extends StEvent{
		
		public static const PASSED:String = "levelPassed";
		public static const FAILED:String = "levelFailed";
		
		public function LevelEndedEvent(type:String){
			super(type);
		}
	}
}