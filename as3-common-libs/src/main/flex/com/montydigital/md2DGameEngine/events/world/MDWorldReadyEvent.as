package com.montydigital.md2DGameEngine.events.world
{
	import com.montydigital.common.events.MDEvent;
	
	public class MDWorldReadyEvent extends MDEvent
	{
		public static const MD_STARLING_WORLD_READY:String = "mdStarlingWorldReady";
		public static const MD_BOX2D_WORLD_READY:String = "mdBox2dWorldReady";
		public static const MD_WORLD_READY:String = "mdWorldReady";
		
		
		public function MDWorldReadyEvent(type:String){
			super(type);
		}
	}
}