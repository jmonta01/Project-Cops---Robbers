package com.montydigital.CopsAndRobbers.engine.entityFramework.components{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;


	public class PhysicsComponent{
		
		public var type:String;
		public var destructible:Boolean=false;
		public var item:BaseBox2dItem;	
		
		public function get x():Number{ return item.x; }
		public function get y():Number{ return item.y; }
		public function get rotation():Number{ return item.rotation; }
		
		public var applyForce:Boolean=false;
		public var force:Number;
		public var contactPoint:b2Vec2;	

	}
}