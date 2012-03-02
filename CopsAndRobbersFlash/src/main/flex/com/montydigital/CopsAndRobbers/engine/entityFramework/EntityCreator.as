package com.montydigital.CopsAndRobbers.engine.entityFramework{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.BulletComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunControlComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories.BulletFactory;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories.CameraFactory;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories.CharacterFactory;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories.ParticleFactory;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories.PropFactory;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.PhysicsEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.vo.Box2DItemEnvPropsVO;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	
	public class EntityCreator{
		
		public static const TYPE_ACTOR:String = "typeActor";
		public static const TYPE_BLOCK:String = "typeBlock";
		public static const TYPE_BULLET:String = "typeBullet";
		public static const TYPE_BOUNDARY:String = "typeBoundary";
		
		private var gameManager:GameManager;
		private var physicsEngine:PhysicsEngine;
		private var layerManager:LayerManager;
		
		public function EntityCreator(gameManager:GameManager, physicsEngine:PhysicsEngine, layerManager:LayerManager){
			this.gameManager = gameManager;
			this.physicsEngine = physicsEngine;
			this.layerManager = layerManager;
		}
		
		public function createLevel(levelData:Object):void{
			
			
			var mapWidth:Number = 2400;
			var mapHeight:Number = 625;

			createGameCamera();
			
			createStaticBarrier(0, mapHeight-10, mapWidth, 10);
			createStaticBarrier(0, 0, mapWidth, 10);
			createStaticBarrier(0, 0, 10, mapHeight);
			createStaticBarrier(mapWidth-10, 0, 10, mapHeight);
			
			for(var x:int=0; x<20; x++){
				createBox(Math.random() * 1200, Math.random() * 600);
			}
			
			createUserCharacter(50, mapHeight-300);
			
			

		}
		

		
		public function createGameCamera():Entity{
			var camera:Entity = CameraFactory.createGameCamera(LayerManager.CamerLayer);
			gameManager.addEntity(camera);
			return camera;
		}

		
		public function createBox(x:Number, y:Number):Entity{
			var box:Entity = PropFactory.generateBox(x, y);			
			gameManager.addEntity(box);
			return box;
		}
		
		public function createStaticBarrier(x:Number, y:Number, width:Number, height:Number):Entity{
			var wall:Entity = PropFactory.generateWall(x, y, width, height);
			gameManager.addEntity(wall);
			return wall;
		}
		
		public function createUserCharacter(x:Number, y:Number):Entity{
			var target:Entity = PropFactory.generateTargeting();
			var userCharacter:Entity = CharacterFactory.generateShooter(x, y);
			
			
			var targetPosComp:PositionComponent = target.getComponent(PositionComponent) as PositionComponent;
			var targetDisplayComp:DisplayComponent = target.getComponent(DisplayComponent) as DisplayComponent;
			
			var targetingComp:TargetingComponent = userCharacter.getComponent(TargetingComponent) as TargetingComponent; 			
			targetingComp.crossHairsPositionComponent = targetPosComp;
			targetingComp.crossHairsDisplayComponent = targetDisplayComp;		
				
				
			gameManager.addEntity(target);
			gameManager.addEntity(userCharacter);		
			
			return userCharacter;
		}

		
		public function createUserBullet(gunComponent:GunComponent, parentPositionComponent:PositionComponent, targetPositionComponent:TargetingComponent):Entity{
			var userBullet:Entity = BulletFactory.generateBullet(gunComponent, parentPositionComponent, targetPositionComponent);
			gameManager.addEntity(userBullet);
			return userBullet;
		}
		
		public function createSpark(type:String, x:Number, y:Number):Entity{
			var spark:Entity = ParticleFactory.generateCollisionSpark(type, x, y);
			gameManager.addEntity(spark);
			return spark;
		}
		
		
		public function destroyEntity(entity:Entity):void{
			var displayComponent:DisplayComponent = entity.getComponent(DisplayComponent) as DisplayComponent;
			if(displayComponent && displayComponent.displayObject){
				this.layerManager.remvoeChildFromLayer(displayComponent.displayObject, displayComponent.layer);
				displayComponent.displayObject.dispose();
			}
			
			var physicsComponent:PhysicsComponent = entity.getComponent(PhysicsComponent) as PhysicsComponent;
			if(physicsComponent && physicsComponent.item)
				this.physicsEngine.removeBody(physicsComponent.item);
			
			this.gameManager.removeEntity(entity);
		}
	}
}