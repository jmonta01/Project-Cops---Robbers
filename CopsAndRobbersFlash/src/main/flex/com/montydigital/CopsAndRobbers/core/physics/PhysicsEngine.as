package com.montydigital.CopsAndRobbers.core.physics{
	import starling.display.StDisplayObject;
	import starling.display.StSprite;

	public class PhysicsEngine{
		
		public static const BOX2D_ENGINE:String = "b2Engine";
		public static const NAPE_ENGINE:String = "napeEngine";
		
		private var engine:IPhysicsEngine;
		
		public function PhysicsEngine(engineType:String){
			switch(engineType){
				case BOX2D_ENGINE: 
					engine = new Box2dEngine();
					break;
				case NAPE_ENGINE: 
					engine = new NapeEngine();
					break;				
			}
		}
		
		public function start():void{
			engine.start();
		}
		
		public function togglePause():void{
			engine.togglePause();
		}
		
		public function stop():void{
			engine.stop();
		}
		
		public function update():void{
			engine.update();
		}
	}
}