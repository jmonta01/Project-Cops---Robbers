package com.montydigital.CopsAndRobbers.controller
{
	import com.montydigital.CopsAndRobbers.commands.social.SocialCommand;
	import com.montydigital.CopsAndRobbers.events.social.SocialEvent;
	import com.montydigital.common.control.AbstractController;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.controller.CentralController;
	
	public class GameController extends AbstractController{
		
		public function GameController(){
			super();
			this.addCommand(SocialEvent.FACEBOOK, SocialCommand);
			this.addCommand(SocialEvent.TWITTER, SocialCommand);
		}
	}
}