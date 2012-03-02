package com.montydigital.CopsAndRobbers.engine.entityFramework.system
{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.ScoringComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.ScoringNode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class ScoringSystem extends System
	{
		private var gameState:GameState;
		
		public function ScoringSystem(gameState:GameState){
			this.gameState = gameState;
		}		

		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( ScoringNode );			
		}
		
		override public function update(time:Number):void{
			var score:ScoringComponent;
			var lastScore:Number;
			for(var node:INode = nodes.head; node; node = node.next){
				score = ScoringNode(node).scoringCompoment;
				lastScore = gameState.score;
				gameState.score += score.scoreToAdd;
				score.scoreToAdd = 0;
			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			
		}
	}
}