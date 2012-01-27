package com.montydigital.md2DGameEngine.commands
{
	import com.montydigital.common.events.IMDEvent;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	public interface IGameCommand{
		function execute(event:IMDEvent) : void;
		function get application():IApplication;
		function set application(val:IApplication):void;
	}
}