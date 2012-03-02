package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.ScoringComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.PhysicsNode;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.DesctructibleBox2dItem;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class CollisionSystem extends System{
		
		private var gameState:GameState;
		private var creator:EntityCreator; 
		
		public function CollisionSystem(gameState:GameState, creator:EntityCreator){
			this.gameState = gameState;
			this.creator = creator;
		}
		
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( PhysicsNode );
		}
		
		override public function update(time:Number):void{
			var physics:PhysicsComponent;
			var score:int=0;
			for(var node:INode = nodes.head; node; node = node.next){
				physics = PhysicsNode(node).physicsComponent;
				if(physics.applyForce){
					creator.createSpark(physics.type, physics.contactPoint.x, physics.contactPoint.y);
					if(physics.item is DesctructibleBox2dItem){
						(physics.item as DesctructibleBox2dItem).applyDestructibleForce(physics.force, physics.contactPoint);
						
						score = physics.force;
						
						if((physics.item as DesctructibleBox2dItem).destroyed){
							if(node.entity.has(CleanupComponent))
								(node.entity.getComponent(CleanupComponent) as CleanupComponent).destroy = true; 
							//TODO - add bonus for destroying an object; 
							score *= 10;
						}
						if(node.entity.has(ScoringComponent))
							(node.entity.getComponent(ScoringComponent) as ScoringComponent).scoreToAdd = score;
					}
					physics.force = 0;
					physics.contactPoint = null;
					physics.applyForce = false;
				}
			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			nodes = null;
		}
	}
}