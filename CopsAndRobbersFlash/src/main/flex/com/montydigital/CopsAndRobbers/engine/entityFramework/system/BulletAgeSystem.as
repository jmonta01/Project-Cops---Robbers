package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.BulletComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.BulletAgeNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class BulletAgeSystem extends System{

		private var creator:EntityCreator;
		
		public function BulletAgeSystem(creator:EntityCreator){
			this.creator = creator;
		}
		
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( BulletAgeNode );			
		}

		
		override public function update(time:Number):void{
			var bullet:BulletComponent;
			for(var node:INode = nodes.head; node; node = node.next){
				bullet = BulletAgeNode(node).bullet;
				
				bullet.lifeRemaining -= time;
				if(bullet.lifeRemaining <= 0 && node.entity.has(CleanupComponent))
					(node.entity.getComponent(CleanupComponent) as CleanupComponent).destroy = true; 
			}
		}

	}
}