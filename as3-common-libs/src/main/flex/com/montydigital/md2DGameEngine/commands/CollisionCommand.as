package com.montydigital.md2DGameEngine.commands{
	import com.montydigital.common.command.ICommand;
	import com.montydigital.common.events.IMDEvent;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionEvent;
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IDestructibleProp;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	public class CollisionCommand implements IGameCommand{
		
		private var e:CollisionEvent;
		
		private var _application:IApplication;
		public function get application():IApplication{ return _application; }
		public function set application(val:IApplication):void{ _application=val; } 
		
		public function CollisionCommand(){}
		
		
		
		public function execute(event:IMDEvent):void{
			e = event as CollisionEvent;
			if(application.mdWorld.getItemByFixture(e.fixture1) is DestructibleProp)
				(application.mdWorld.getItemByFixture(e.fixture1) as DestructibleProp).applyForce(e.impulse.normalImpulses[0]);
			if(application.mdWorld.getItemByFixture(e.fixture2) is DestructibleProp)
				(application.mdWorld.getItemByFixture(e.fixture2) as DestructibleProp).applyForce(e.impulse.normalImpulses[0]);
		}
	}
}