package com.montydigital.CopsAndRobbers.engine.entityFramework.system
{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.AiComonent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.AiNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class AiSystem extends System{
		
		public function AiSystem(){
		}
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( AiNode );
		}
		
		override public function update(time:Number):void{
			for(var node:INode = nodes.head; node; node = node.next){
				
			}
		}

	}
}