package com.montydigital.common.events.initializers
{
	import com.montydigital.common.events.MDEvent;
	
	public class InitializerSuccessEvent extends MDEvent
	{
		
		public static var SUCCESS:String = "INITIALIZER_SUCCESS";
		
		public var initializerName:String;
		
		public function InitializerSuccessEvent(initializerName:String)
		{
			super(SUCCESS);
			this.initializerName = initializerName;
		}
	}
}