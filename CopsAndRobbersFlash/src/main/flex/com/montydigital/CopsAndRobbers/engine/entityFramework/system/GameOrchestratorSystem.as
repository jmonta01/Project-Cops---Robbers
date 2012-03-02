package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameStateNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.system.ISystem;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.Hud;
	import com.montydigital.gameEngine.entityFramework.system.System;
	
	public class GameOrchestratorSystem extends System{
		
		private var gameState:GameState;
		private var creator:EntityCreator; 
		
		/*
			This system manages the state of the game level, ie: bullet count, level complete, etc..
		*/
		
		public function GameOrchestratorSystem(gameState:GameState, creator:EntityCreator){
			this.gameState = gameState;
			this.creator = creator;
		}
		
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( GameStateNode );
		}
		
		override public function update(time:Number):void{
			var component:GameStateComponent;
			var enemyCount:int = 0;
			var destructiblePropCount:int = 0;
			var hud:Hud;
			
			this.gameState.time += time;
			for(var node:INode = nodes.head; node; node = node.next){
				component = GameStateNode(node).gameStateComponent;
				if(component.entityType == GameStateComponent.TYPE_DESCRUCTIBLE_PROP)
					destructiblePropCount += 1;
				if(component.entityType == GameStateComponent.TYPE_ENEMY)
					enemyCount += 1;
			}
			this.gameState.enemies = enemyCount;
			//enemyCount <= 0 || 
			if(destructiblePropCount <= 0){
				this.gameState.levelEnded = true;
				this.gameState.levelPassed = true;
			}
			if((this.gameState.time <= 0 && this.gameState.time > -1) || (this.gameState.totalRounds <= 0 && this.gameState.totalRounds > -1)){
				this.gameState.levelEnded = true;
				this.gameState.levelPassed = false;
			}
			
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			nodes = null;
		}
	}
}