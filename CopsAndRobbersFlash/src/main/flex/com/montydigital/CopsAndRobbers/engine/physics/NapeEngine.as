package com.montydigital.CopsAndRobbers.engine.physics{
	
//	import nape.geom.Vec2;
//	import nape.space.Space;


	public class NapeEngine implements IPhysicsEngine{
		
//		private var space:Space;
		
		private static var instance:NapeEngine;
		public static function getInstance():NapeEngine{
			if(!NapeEngine.instance)
				NapeEngine.instance = new NapeEngine(new SingletonEnforcer());
			return NapeEngine.instance;
		}
		
		public function NapeEngine(enforcer:SingletonEnforcer){
			if(!enforcer)
				throw new Error("This is a singleton, use the getInstance method");
//			space = new Space(new Vec2(0, 3000));
		}
		
		public function addBody(body:*):void{
			
		}
		
		public function start():void{
			
		}
		
		public function togglePause():void{
			
		}
		
		public function update():void{
			
		}
		
		public function stop():void{
			
		}
	}
}
class SingletonEnforcer{}