package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.PhysicsNode;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.PhysicsEngine;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class PhysicsSystem extends System{
		
		private var engine:PhysicsEngine;
		
		public function PhysicsSystem(engine:PhysicsEngine){
			this.engine = engine;
		}
		
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList(PhysicsNode);
			this.engine.start();
		}
		
		override public function update(time:Number):void{
			this.engine.update();
			var physicsComponent:PhysicsComponent;
			var positionComponent:PositionComponent;

			for(var node:INode = nodes.head; node; node = node.next){
				physicsComponent = PhysicsNode(node).physicsComponent;
				positionComponent = PhysicsNode(node).positionComponent;
				
				positionComponent.x = physicsComponent.x*Box2dEngine.RATIO;
				positionComponent.y = physicsComponent.y*Box2dEngine.RATIO;;
				positionComponent.rotation = physicsComponent.rotation;
			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			this.engine.stop();
			nodes = null;
		}

	}
}