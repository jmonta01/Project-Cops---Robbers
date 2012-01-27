package com.montydigital.common.events.services
{
	import com.montydigital.common.events.MDEvent;
	
	public class ServiceStatusEvent extends MDEvent
	{
		public static const START:String = "serviceStart";
		public static const STOP:String = "serviceStop";
		
		public function ServiceStatusEvent(type:String)
		{
			super(type);
		}
	}
}