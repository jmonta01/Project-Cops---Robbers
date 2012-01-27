package com.montydigital.CopsAndRobbers.core.entityFramework.system
{
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.GameState;

	public class ScoringSystem implements ISystem
	{
		
		private var gameState:GameState;
		
		public function ScoringSystem(gameState:GameState){
			this.gameState = gameState;
		}
		
		public function update(time:Number):void{
		}
		
		public function start():void
		{
		}
		
		public function stop():void
		{
		}
	}
}