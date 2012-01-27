package com.montydigital.common.events.services
{
	import com.montydigital.common.events.MDEvent;

	
	public class MD_HTTServiceFaultEvent extends MDEvent
	{
		public static const FAULT:String = "BD_HTTP_SERVICE_FAULT";
		
		public var url:String;
		
		public function MD_HTTServiceFaultEvent(url:String)
		{
			this.url = url;
			super(FAULT);
		}
	}
}