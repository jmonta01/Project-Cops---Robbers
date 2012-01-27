package com.montydigital.CopsAndRobbers.commands.social{
	import com.montydigital.CopsAndRobbers.events.social.SocialEvent;
	import com.montydigital.common.command.ICommand;
	import com.montydigital.common.events.IMDEvent;
	
	public class SocialCommand implements ICommand{
		
		private var e:SocialEvent;
		
		public function SocialCommand(){}
		
		public function execute(event:IMDEvent):void{
			e = SocialEvent(event);
			trace("triggered: "+e.type);			
		}
	}
}