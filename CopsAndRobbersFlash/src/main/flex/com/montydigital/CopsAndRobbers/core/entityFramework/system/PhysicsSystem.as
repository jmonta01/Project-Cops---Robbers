package com.montydigital.CopsAndRobbers.core.entityFramework.system{
	import com.montydigital.CopsAndRobbers.core.physics.PhysicsEngine;

	public class PhysicsSystem implements ISystem{
		
		private var engine:PhysicsEngine;
		
		public function PhysicsSystem(engine:PhysicsEngine){
			this.engine = engine;
		}
		
		public function update(time:Number):void{
			this.engine.update();
		}
		
		public function start():void{
			this.engine.start();
		}
		
		public function stop():void{
			this.engine.stop();
		}
	}
}