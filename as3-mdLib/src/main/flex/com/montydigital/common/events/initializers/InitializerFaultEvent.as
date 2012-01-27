package com.montydigital.common.events.initializers
{
	import com.montydigital.common.events.MDEvent;
	
	public class InitializerFaultEvent extends MDEvent
	{
		
		public static var FAULT:String = "INITIALIZER_FAULT";
		
		public var initializerName:String;
		
		public function InitializerFaultEvent(initializerName:String)
		{
			super(FAULT);
			this.initializerName = initializerName;
		}
	}
}