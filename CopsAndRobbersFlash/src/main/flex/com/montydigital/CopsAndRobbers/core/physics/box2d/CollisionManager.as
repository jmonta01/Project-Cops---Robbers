package com.montydigital.CopsAndRobbers.core.physics.box2d{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactFilter;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionEvent;
	
	public class CollisionManager extends b2ContactListener
	{
		public var contactFilter:b2ContactFilter;
		
		public function CollisionManager()
		{
			super();
		}
		
		
		/* contactListener interface */
		
		override public function BeginContact(contact:b2Contact):void{
			super.BeginContact(contact);
			var evt:CollisionEvent = new CollisionEvent(CollisionEvent.BeginContact);
			evt.fixture1 = contact.GetFixtureA();
			evt.fixture2 = contact.GetFixtureB();
			evt.dispatch();
		}
		
		override public function EndContact(contact:b2Contact):void{
			super.EndContact(contact);
			var evt:CollisionEvent = new CollisionEvent(CollisionEvent.EndContact);
			evt.fixture1 = contact.GetFixtureA();
			evt.fixture2 = contact.GetFixtureB();
			evt.dispatch();
		}
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void{
			super.PreSolve(contact, oldManifold);
			var evt:CollisionEvent = new CollisionEvent(CollisionEvent.PreSolve);
			evt.fixture1 = contact.GetFixtureA();
			evt.fixture2 = contact.GetFixtureB();
			evt.dispatch();
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void{
			super.PostSolve(contact, impulse);
			var evt:CollisionEvent = new CollisionEvent(CollisionEvent.PostSolve);
			evt.fixture1 = contact.GetFixtureA();
			evt.fixture2 = contact.GetFixtureB();
			evt.impulse = impulse;
			evt.dispatch();
		}
	}
}