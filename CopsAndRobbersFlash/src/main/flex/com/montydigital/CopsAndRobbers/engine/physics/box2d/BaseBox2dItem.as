package com.montydigital.CopsAndRobbers.engine.physics.box2d
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.vo.Box2DItemEnvPropsVO;
	
	import flash.geom.Point;


	public class BaseBox2dItem implements IAbstractBox2dItem{
		
		public static const STATIC_BODY:int = b2Body.b2_staticBody;
		public static const KINEMATIC_BODY:int = b2Body.b2_kinematicBody;
		public static const DYNAMIC_BODY:int = b2Body.b2_dynamicBody;
		
		private var bodyDef:b2BodyDef;
		private var body:b2Body;
		private var  fixtureDef:b2FixtureDef;
		private var fixture:b2Fixture;
		
		//env props
		private var _envProps:Box2DItemEnvPropsVO;
		public function get envProps():Box2DItemEnvPropsVO{ return _envProps; }
		public function set envProps(val:Box2DItemEnvPropsVO):void{ _envProps = val; }
		
		//position props
		public function get x():Number{ return body.GetPosition().x; }
		public function get y():Number{ return body.GetPosition().y; }
		public function get rotation():Number{ return body.GetAngle(); }
		
		public function getBody():b2Body{ return body; }
		
		public function BaseBox2dItem(){}
		
		public function setWithVertices(vertices:Array, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(x/Box2dEngine.RATIO, y/Box2dEngine.RATIO);
			this.bodyDef.angle = rotation;
			this.bodyDef.type = (bodyType < 0) ? BaseBox2dItem.DYNAMIC_BODY : bodyType;

			this.body = Box2dEngine.CreateBody(this.bodyDef);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsArray(vertices, vertices.length);
			var massData:b2MassData = new b2MassData();
			massData.mass = envProps.mass;
			shape.ComputeMass(massData, envProps.density);

			
			this.fixtureDef = new b2FixtureDef();
			this.fixtureDef.shape = shape;
			this.fixtureDef.density = this.envProps.density;
			this.fixtureDef.friction = this.envProps.friction;
			this.fixtureDef.restitution = this.envProps.restitution;
			
			fixture = this.body.CreateFixture(this.fixtureDef);	
		}
		
		public function setWithSquare(width:Number, height:Number, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(x, y);
			this.bodyDef.angle = rotation;
			this.bodyDef.type = (bodyType < 0) ? BaseBox2dItem.DYNAMIC_BODY : bodyType;
			
			this.body = Box2dEngine.CreateBody(this.bodyDef);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width/2, height/2);
			var massData:b2MassData = new b2MassData();
			massData.mass = envProps.mass;
			shape.ComputeMass(massData, envProps.density);
			
			
			this.fixtureDef = new b2FixtureDef();
			this.fixtureDef.shape = shape;
			this.fixtureDef.density = this.envProps.density;
			this.fixtureDef.friction = this.envProps.friction;
			this.fixtureDef.restitution = this.envProps.restitution;
			
			fixture = this.body.CreateFixture(this.fixtureDef);	

		}
		
		public function setWithCircle(radius:Number, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(x, y);
			this.bodyDef.angle = rotation*(Math.PI/180);
			this.bodyDef.type = (bodyType < 0) ? BaseBox2dItem.DYNAMIC_BODY : bodyType;
			
			this.body = Box2dEngine.CreateBody(this.bodyDef);
			
			var shape:b2CircleShape = new b2CircleShape(radius);
			
			var massData:b2MassData = new b2MassData();
			massData.mass = envProps.mass;
			shape.ComputeMass(massData, envProps.density);
			
			
			this.fixtureDef = new b2FixtureDef();
			this.fixtureDef.shape = shape;
			this.fixtureDef.density = this.envProps.density;
			this.fixtureDef.friction = this.envProps.friction;
			this.fixtureDef.restitution = this.envProps.restitution;
			
			fixture = this.body.CreateFixture(this.fixtureDef);	

		}
		
		
		public function set userData(data:PhysicsComponent):void{
			body.SetUserData(data);
		}		
		public function get userData():PhysicsComponent{
			var data:* = body.GetUserData(); 
			return (data is PhysicsComponent) ? data : null;
		}
		
		public function applyImpulse(impulse:b2Vec2):void{
			body.ApplyImpulse(impulse, body.GetWorldCenter());
		}
		

	}
}