package com.montydigital.md2DGameEngine.events.world{
	import com.montydigital.common.events.MDEvent;	
	public class MDWorldLockedEvent extends MDEvent{
		
		public static const UNLOCKED:String = "MDWorldUnlocked";
		public static const LOCKED:String = "MDWorldLocked";
		
		public function MDWorldLockedEvent(type:String){
			super(type);
		}
	}
}