package com.montydigital.CopsAndRobbers.engine.physics.box2d{
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactFilter;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	
	import flash.geom.Point;

	
	public class CollisionManager extends b2ContactListener
	{
		public var contactFilter:b2ContactFilter;
		
		public function CollisionManager(){
			super();
			contactFilter = new b2ContactFilter();
		}
		
		
		/* contactListener interface */
/*		
		
		
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
*/		
		
		override public function BeginContact(contact:b2Contact):void{
			

		}
		

		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void{
			if(impulse.normalImpulses[0] > 1){
				
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();	
				
				var physicsComponentA:PhysicsComponent = bodyA.GetUserData() as PhysicsComponent;
				var physicsComponentB:PhysicsComponent = bodyB.GetUserData() as PhysicsComponent;
				
				if(physicsComponentA && physicsComponentB){
					
					var manifold:b2WorldManifold = new b2WorldManifold();
					contact.GetWorldManifold(manifold);
					var contactPoint:b2Vec2 = manifold.m_points[0] as b2Vec2;
					
					if(physicsComponentA.type != EntityCreator.TYPE_BULLET && physicsComponentB.type == EntityCreator.TYPE_BULLET){
						physicsComponentA.applyForce = true;
						physicsComponentA.contactPoint= contactPoint;
						physicsComponentA.force = impulse.normalImpulses[0];
					}
					
					if(physicsComponentB.type != EntityCreator.TYPE_BULLET && physicsComponentA.type == EntityCreator.TYPE_BULLET){
						physicsComponentB.applyForce = true;
						physicsComponentB.contactPoint= contactPoint;
						physicsComponentB.force = impulse.normalImpulses[0];
					}
				}
			}

		}
	}
}