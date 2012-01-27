package com.montydigital.common.initializers
{
	import com.montydigital.common.events.MDEvent;

	public interface IInitializer
	{
		function execute():void;
		function success(event:MDEvent):void;
		function fault(event:MDEvent):void;
		
		function getName():String;
	}
}