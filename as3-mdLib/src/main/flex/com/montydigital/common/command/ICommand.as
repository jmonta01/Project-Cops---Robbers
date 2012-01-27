package com.montydigital.common.command
{
	import com.montydigital.common.events.IMDEvent;

	public interface ICommand
	{
		function execute(event:IMDEvent) : void;
		
	}
}