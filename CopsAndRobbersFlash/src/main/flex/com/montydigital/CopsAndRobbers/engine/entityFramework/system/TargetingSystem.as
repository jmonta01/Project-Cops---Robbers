package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.input.UserIntentCapture;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.TargetingNode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class TargetingSystem extends System{
		
		private var userIntentCapture:UserIntentCapture;
		
		public function TargetingSystem(userIntentCapture:UserIntentCapture){
			this.userIntentCapture = userIntentCapture;
			super();
		}
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList(TargetingNode);
		}
		
		override public function update(time:Number):void{
			var targetingComponent:TargetingComponent;			
			for(var node:INode = nodes.head; node; node = node.next){
				targetingComponent = TargetingNode(node).targetingComponent;

				targetingComponent.firing = userIntentCapture.firing;
				targetingComponent.crossHairsPositionComponent.x = targetingComponent.x = userIntentCapture.targetCoords.x;	
				targetingComponent.crossHairsPositionComponent.y = targetingComponent.y = userIntentCapture.targetCoords.y;
				targetingComponent.crossHairsDisplayComponent.visible = userIntentCapture.touching && !userIntentCapture.zoomingOrPanning;
				
				userIntentCapture.firing = false;
			}
		}
		
		override public function removeFromGame(game:GameManager):void{
			nodes = null;
		}
	}
}