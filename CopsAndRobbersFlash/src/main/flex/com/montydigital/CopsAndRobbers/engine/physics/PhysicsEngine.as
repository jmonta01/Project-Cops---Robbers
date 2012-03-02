package com.montydigital.CopsAndRobbers.engine.physics{
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;
	
	import starling.display.StDisplayObject;
	import starling.display.StSprite;

	public class PhysicsEngine{
		
		public static const BOX2D_ENGINE:String = "b2Engine";
		public static const NAPE_ENGINE:String = "napeEngine";
		
		private var engine:IPhysicsEngine;
		
		public function PhysicsEngine(engineType:String){
			switch(engineType){
				case BOX2D_ENGINE: 
					engine = Box2dEngine.getInstance();
					break;
				case NAPE_ENGINE: 
					engine = NapeEngine.getInstance();
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
		
		public function removeBody(body:BaseBox2dItem):void{
			Box2dEngine.DestroyBody(body.getBody());
		}
		
		public function getBodies():Array{
			var bodies:Array = [];
			
			return bodies;
		}
	}
}