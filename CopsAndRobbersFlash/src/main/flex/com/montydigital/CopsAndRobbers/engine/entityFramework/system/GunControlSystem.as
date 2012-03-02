package com.montydigital.CopsAndRobbers.engine.entityFramework.system{
	
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunControlComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GunControlNode;
	import com.montydigital.gameEngine.entityFramework.node.INode;
	import com.montydigital.gameEngine.entityFramework.system.System;

	public class GunControlSystem extends System{
	
		private var creator:EntityCreator;
		private var gameState:GameState;
		
		public function GunControlSystem(creator:EntityCreator, gameState:GameState){
			this.creator = creator;
			this.gameState = gameState;
		}
			
		
		override public function addToGame(gameManager:GameManager):void{
			nodes = gameManager.getNodeList( GunControlNode );			
		}
		
		override public function update(time:Number):void{
			var gunControlComponent:GunControlComponent;
			var gunComponent:GunComponent;
			var positionComponent:PositionComponent;
			var userControlComponent:TargetingComponent;
			
			for(var node:INode = nodes.head; node; node = node.next){
				gunControlComponent = GunControlNode(node).gunControlComponent;
				userControlComponent = GunControlNode(node).userControlComponent;
				gunComponent = GunControlNode(node).gunComponent;
				positionComponent = GunControlNode(node).positionComponent;
				
				
				gunComponent.timeSinceLastShot += time;
				gunComponent.shooting = userControlComponent.firing; 
				
				if(gunComponent.shooting && gunComponent.timeSinceLastShot >= gunComponent.minimumShotInterval){
					
					if(gunComponent.currentBulletsInClip > 0){
						gunComponent.currentBulletsInClip -= 1;	
						creator.createUserBullet(gunComponent, positionComponent, userControlComponent);
						gunComponent.timeSinceLastShot = 0;
						this.gameState.totalRounds -= 1;
//						trace("fire from ("+positionComponent.x+", "+positionComponent.y+") -> ("+userControlComponent.x+", "+userControlComponent.y+")");
					}else{
						trace("reload");
						gunComponent.timeSinceLastShot = 0;
						gunComponent.currentBulletsInClip = gunComponent.totalBulletsInClip;
					}			
					this.gameState.roundsInClip = gunComponent.currentBulletsInClip;
				}
				gunComponent.shooting = userControlComponent.firing = false;			}
		}
		
		override public function removeFromGame(gameManager:GameManager):void{
			nodes = null;	
		}
	}
}