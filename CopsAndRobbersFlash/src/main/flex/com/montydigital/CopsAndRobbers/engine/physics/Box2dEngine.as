package com.montydigital.CopsAndRobbers.engine.physics{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.CollisionManager;
	
	import flash.display.Sprite;
	
	import starling.display.StDisplayObject;
	import starling.display.StSprite;

	public class Box2dEngine implements IPhysicsEngine{
		
		public static var debugSprite:Sprite
		public static const RATIO:Number = 30;
		private static const DEFAULT_TIMESTEP:Number = 1/60;
		
		private var _b2World:b2World;
		private var gravityVector:b2Vec2;
		private var collisionManager:CollisionManager;
		
		
		
		private var timeStep:Number=DEFAULT_TIMESTEP;
		private var velicotyIterator:int=3;
		private var positionIterator:int=3;		
		
		private static var instance:Box2dEngine;
		public static function getInstance():Box2dEngine{
			if(!Box2dEngine.instance)
				Box2dEngine.instance = new Box2dEngine(new SingletonEnforcer());
			return Box2dEngine.instance;
		}
		public function Box2dEngine(enforcer:SingletonEnforcer){
			if(!enforcer){
				throw new Error("This is a singleton, use the getInstance method");
			}else{
				gravityVector = new b2Vec2(0, 9.8);			
				_b2World = new b2World(gravityVector, false);
				collisionManager = new CollisionManager();
				_b2World.SetContactListener(collisionManager);
				_b2World.SetContactFilter(collisionManager.contactFilter);
			}
		}
		
		public function setupDebugMode():void{
			var previewSprite:Sprite = new Sprite();
			Box2dEngine.debugSprite.addChild(previewSprite);
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(previewSprite);
			debugDraw.SetDrawScale(RATIO);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			debugDraw.SetLineThickness(1);
			debugDraw.SetFillAlpha(.3);
			_b2World.SetDebugDraw(debugDraw);

		}
		
		public static function CreateBody(def:b2BodyDef):b2Body{
			return Box2dEngine.instance._b2World.CreateBody(def);
		}
		
		public static function DestroyBody(body:b2Body):void{
			Box2dEngine.instance._b2World.DestroyBody(body);
		}
			
		
		public function togglePause():void{
			timeStep = (timeStep == 0) ? DEFAULT_TIMESTEP : 0;
		}
		
		public function start():void{
//			setupDebugMode();
		}
		
		public function update():void{
			_b2World.Step(timeStep, velicotyIterator, positionIterator);
			_b2World.ClearForces();	
		}
		
		public function stop():void{
			
		}
	}
}
class SingletonEnforcer{}