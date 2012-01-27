package com.montydigital.CopsAndRobbers.core.entityFramework.system{
	import com.montydigital.CopsAndRobbers.core.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.GameState;

	public class CollisionSystem implements ISystem{
		
		private var gameState:GameState;
		private var creator:EntityCreator; 
		
		public function CollisionSystem(gameState:GameState, creator:EntityCreator){
			this.gameState = gameState;
			this.creator = creator;
		}
		
		public function update(time:Number):void
		{
		}
		
		public function start():void
		{
		}
		
		public function stop():void
		{
		}
	}
}