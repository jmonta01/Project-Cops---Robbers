package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.DisplayNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	
	import starling.display.StDisplayObject;
	import starling.display.StSprite;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class RenderSystem extends System
	{
		private var creator:EntityCreator;
		private var layerManager:LayerManager;
		
		public function RenderSystem(layerManager:LayerManager, creator:EntityCreator){
			this.layerManager = layerManager;
			this.creator = creator;
		}
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( DisplayNode );	
			for(var node:INode = nodes.head; node; node = node.next){
				addToDisplay(DisplayNode(node).displayComponent);				
			}
		}
		
		private function addToDisplay(displayComp:DisplayComponent):void{
			if(!displayComp.added){
				layerManager.addChildToLayer(displayComp.displayObject, displayComp.layer);
				displayComp.added = true;
			}
		}
		
		override public function update(time:Number):void{
			var positionComponent:PositionComponent;
			var displayComponent:DisplayComponent;
			var displayObject:StDisplayObject;
			
			for(var node:INode = nodes.head; node; node = node.next){
				displayComponent = DisplayNode(node).displayComponent;
				displayObject = displayComponent.displayObject;
				positionComponent = DisplayNode(node).positionComponent;

				if(!displayComponent.added)
					addToDisplay(displayComponent);
				
				displayObject.visible = displayComponent.visible;
				displayObject.x = positionComponent.x;
				displayObject.y = positionComponent.y;
				displayObject.rotation = positionComponent.rotation;
				
				if(displayComponent.hasTimeout){
					displayComponent.timeRemaining -= time;
					if(displayComponent.timeRemaining <= 0 && node.entity.has(CleanupComponent))
						(node.entity.getComponent(CleanupComponent) as CleanupComponent).destroy = true; 
				}
			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			nodes = null;
		}
	}
}