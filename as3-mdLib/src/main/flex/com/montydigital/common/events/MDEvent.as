package com.montydigital.common.events
{
	import flash.events.Event;
	
	public class MDEvent extends Event implements IMDEvent 	{
		public function MDEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function dispatch():void{
			MDEventDispatcher.getInstance().dispatchEvent(this);
		}
	}
}