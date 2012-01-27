package com.montydigital.common.events.initializers
{
	import com.montydigital.common.events.MDEvent;
	
	public class InitializationCompleteEvent extends MDEvent
	{
		
		public static var COMPLETE:String = "NOTIFY_INITIALIZATION_COMPLETE";

		public function InitializationCompleteEvent()
		{
			super(COMPLETE);
		}
	}
}