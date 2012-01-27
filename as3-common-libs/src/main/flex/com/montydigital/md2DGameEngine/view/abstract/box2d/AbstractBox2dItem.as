package com.montydigital.md2DGameEngine.view.abstract.box2d
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.geom.Point;

	public class AbstractBox2dItem implements IAbstractBox2dItem{
		
		public static const STATIC_BODY:int = b2Body.b2_staticBody;
		public static const KINEMATIC_BODY:int = b2Body.b2_kinematicBody;
		public static const DYNAMIC_BODY:int = b2Body.b2_dynamicBody;
		
	
		private var _bodyDef:b2BodyDef;
		public function get bodyDef():b2BodyDef{ return _bodyDef; }
		public function set bodyDef(val:b2BodyDef):void{ _bodyDef = val; }
				
		private var _body:b2Body;
		public function get body():b2Body{ return _body; }
		public function set body(val:b2Body):void{ _body = val; }
				
//		private var _shape:b2PolygonShape;
//		public function get shape():b2PolygonShape{ return _shape; }
//		public function set shape(val:b2PolygonShape):void{ _shape = val; }
		
		private var _fixtureDef:b2FixtureDef;
		public function get fixtureDef():b2FixtureDef{ return _fixtureDef; }
		public function set fixtureDef(val:b2FixtureDef):void{ _fixtureDef = val; }
		
		private var _fixture:b2Fixture;
		public function get fixture():b2Fixture{ return _fixture; }
		public function set fixture(val:b2Fixture):void{ _fixture = val; }
		
		//env props
		private var envProps:Box2DItemEnvPropsVO;
		
		public function get density():Number{ return envProps.density; }
		public function set density(val:Number):void{ envProps.density = val; }
		
		public function get friction():Number{ return envProps.friction; }
		public function set friction(val:Number):void{ envProps.friction = val; }
		
		public function get restitution():Number{ return envProps.restitution; }
		public function set restitution(val:Number):void{ envProps.restitution = val; }
		
		public function AbstractBox2dItem(){}
		
		public function setWithVertices(vertices:Array, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(initialCoords.position.x, initialCoords.position.y);
			this.bodyDef.angle = initialCoords.angle;
			this.bodyDef.type = (bodyType < 0) ? AbstractBox2dItem.DYNAMIC_BODY : bodyType;

			this.body = MDB2World.CreateBody(this.bodyDef);
			
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
		
		public function setWithSquare(width:Number, height:Number, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(initialCoords.position.x, initialCoords.position.y);
			this.bodyDef.angle = initialCoords.angle;
			this.bodyDef.type = (bodyType < 0) ? AbstractBox2dItem.DYNAMIC_BODY : bodyType;
			
			this.body = MDB2World.CreateBody(this.bodyDef);
			
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
		
		public function setWithCircle(radius:Number, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void{
			this.envProps = envProps;	
			
			this.bodyDef = new b2BodyDef();
			this.bodyDef.position.Set(initialCoords.position.x, initialCoords.position.y);
			this.bodyDef.angle = initialCoords.angle*(Math.PI/180);
			this.bodyDef.type = (bodyType < 0) ? AbstractBox2dItem.DYNAMIC_BODY : bodyType;
			
			this.body = MDB2World.CreateBody(this.bodyDef);
			
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
	}
}