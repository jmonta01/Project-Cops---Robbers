package com.montydigital.md2DGameEngine.controller{
	import com.montydigital.common.control.AbstractController;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.commands.CollisionCommand;
	import com.montydigital.md2DGameEngine.commands.DestroyedCommand;
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionEvent;
	import com.montydigital.md2DGameEngine.utilities.collision.DestroyedEvent;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import starling.display.StSprite;
	
	public class CentralController extends GameAbstractController{
		
		
		
		public function CentralController(application:IApplication){
			super();
			addCommand(CollisionEvent.PostSolve, CollisionCommand, application);
			addCommand(DestroyedEvent.DESTROYED, DestroyedCommand, application);
		}
	}
}