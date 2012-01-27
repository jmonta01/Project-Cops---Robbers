package com.montydigital.CopsAndRobbers.core.entityFramework.system{
	
	import com.montydigital.CopsAndRobbers.core.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.ISystem;
	
	public class GameOrchestrator implements ISystem{
		
		private var gameState:GameState;
		private var creator:EntityCreator; 
		
		public function GameOrchestrator(gameState:GameState, creator:EntityCreator){
			this.gameState = gameState;
			this.creator = creator;
		}
		
		public function start():void{
			
		}
		
		public function update(time:Number):void{
		}
		
		public function stop():void{
		}
	}
}