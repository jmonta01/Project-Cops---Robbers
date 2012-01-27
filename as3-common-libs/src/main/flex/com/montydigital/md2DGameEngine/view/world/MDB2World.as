package com.montydigital.md2DGameEngine.view.world
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import starling.display.StDisplayObject;

	public class MDB2World{
		
		public static const RATIO:Number = 30;
		public static const GRAVITY_FORCE:Number = 10;
		
		private var _stage:Stage;
		private var _b2World:b2World;
		private var _gravityVec:b2Vec2;
		
		private var timeStep:Number = 1/60;
		private var velIter:int = 20;
		private var posIter:int = 20;
		
		private var destroyList:Array;
		
		private var debugViewSet:Boolean = false;
		private var _debugMode:Boolean = false;
		public function get debugMode():Boolean{ return _debugMode; }
		public function set debugMode(val:Boolean):void{ _debugMode = val; }

		
		public static function CreateBody(def:b2BodyDef):b2Body{
			return MDB2World.instance._b2World.CreateBody(def);
		}
		
		public static function DestroyBody(body:b2Body):void{
			MDB2World.instance.destroyList.push(body);		
		}

		
		public function get isLocked():Boolean{
			return _b2World.IsLocked();
		}
		
		public function loop():void{
			while(destroyList.length > 0){
				_b2World.DestroyBody(destroyList.pop());
			}
			
			_b2World.Step(timeStep, velIter, posIter);
			_b2World.ClearForces();	
			
			for(var bb:b2Body = _b2World.GetBodyList(); bb; bb = bb.GetNext()){
				if(bb.GetUserData() is StDisplayObject){
					var sprite:StDisplayObject = bb.GetUserData() as StDisplayObject;
					sprite.x = bb.GetPosition().x * RATIO;
					sprite.y = bb.GetPosition().y * RATIO;
					sprite.rotation = bb.GetAngle();
				}
			}			
			if(debugMode && debugViewSet) _b2World.DrawDebugData();
		}
		
		public function setupDebugMode():void{
			debugViewSet = true;
			var previewSprite:Sprite = new Sprite();
			_stage.addChild(previewSprite);		
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(previewSprite);
			debugDraw.SetDrawScale(RATIO);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			debugDraw.SetLineThickness(1);
			debugDraw.SetFillAlpha(.3);
			_b2World.SetDebugDraw(debugDraw);
		}
		
		
		/* Singleton Setup */
		
		private static var instance:MDB2World;
		
		public static function initInstance(stage:Stage):MDB2World{
			if(!MDB2World.instance){ 
				MDB2World.instance = new MDB2World(new SingletonEnforcer());
				MDB2World.instance._stage = stage;
				return MDB2World.instance;
			}else{
				throw new Error("This Singleton method: initInstance should only be called on creation of this singleton. Use the getInstance method");
			}
		}
		
		public static function getInstance():MDB2World{
			if(MDB2World.instance){ 
				return MDB2World.instance;
			}else{
				throw new Error("This singleton has not been initialized yet. Use the initInstance to initialize it.");
			}				
		}
		
		public function MDB2World(enforcer:SingletonEnforcer){			
			if(enforcer){
				_gravityVec = new b2Vec2(0, 9.8);			
				_b2World = new b2World(_gravityVec, false);
				_b2World.SetContactListener(CollisionManager.getInstance());
				_b2World.SetContactFilter(CollisionManager.getInstance().contactFilter);
				destroyList = new Array();
			}else{
				throw new Error("This is a Singleton use the initInstance method, then getInstance method.");
			}
		}
		
	}
}
class SingletonEnforcer{}