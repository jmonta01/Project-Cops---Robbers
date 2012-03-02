package com.montydigital.CopsAndRobbers.engine.entityFramework.system
{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.AiComonent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.CleanupNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class CleanupSystem extends System
	{
		
		private var creator:EntityCreator;
		
		public function CleanupSystem(creator:EntityCreator){
			this.creator = creator;
		}
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( CleanupNode );
		}
		
		override public function update(time:Number):void{
			var component:CleanupComponent;
			for(var node:INode = nodes.head; node; node = node.next){
				component = CleanupNode(node).cleanupComponent;
				if(component.destroy) creator.destroyEntity(node.entity);
			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			var component:CleanupComponent;
			for(var node:INode = nodes.head; node; node = node.next){
				component = CleanupNode(node).cleanupComponent;
				creator.destroyEntity(node.entity);
			}
			nodes = null;
		}
	}
}