package com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.BulletComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.vo.Box2DItemEnvPropsVO;
	
	import flash.geom.Point;
	
	import starling.display.StImage;

	public class BulletFactory{
		
		public static function generateBullet(gunComponent:GunComponent, parentPositionComponent:PositionComponent, targetPositionComponent:TargetingComponent):Entity{
			var entity:Entity = new Entity();
			
			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_BULLET;
				entity.addComponent(gameState);	
			
			var display:DisplayComponent = new DisplayComponent();
				display.layer = LayerManager.GAME_LAYER;
				display.displayObject = StImage.fromBitmap(new TempMaps.MANHOLE_COVER());
				display.displayObject.scaleX = display.displayObject.scaleY = .25;
				entity.addComponent(display);
			
			var parentCoord:Point = new Point(parentPositionComponent.x, parentPositionComponent.y);
			
			//LayerManager.CamerLayer.globalToLocal()
				
			var position:PositionComponent = new PositionComponent();
				position.x = parentCoord.x + gunComponent.offsetFromParent.x - display.displayObject.width/2;
				position.y = parentCoord.y + gunComponent.offsetFromParent.y - display.displayObject.height/2;
				position.rotation = parentPositionComponent.rotation;
				entity.addComponent(position);
				
				display.displayObject.x = position.x;
				display.displayObject.y = position.y;
				
			var physics:PhysicsComponent = new PhysicsComponent();	
				physics.type = EntityCreator.TYPE_BULLET;
				var width:Number = display.displayObject.width/Box2dEngine.RATIO;
				var height:Number = display.displayObject.height/Box2dEngine.RATIO;
				var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];				
				var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(1, 3, 1, .1, true); 
				var box2dItem:BaseBox2dItem = new BaseBox2dItem();			
				box2dItem.setWithVertices(verts, position.x, position.y, 0, props, BaseBox2dItem.DYNAMIC_BODY);
				box2dItem.userData = physics;
				physics.item = box2dItem;						
				entity.addComponent(physics);
				
				
				/* apply initial force from the shot */
				var distX:Number = (targetPositionComponent.x - display.displayObject.width/2 - position.x); //
				var distY:Number = (targetPositionComponent.y - display.displayObject.height/2 - position.y); //mouseY - bulletOriginY
				var angle:Number = Math.atan2(distY, distX);				
				var impulseForce:b2Vec2 = new b2Vec2(Math.cos(angle)/Box2dEngine.RATIO, Math.sin(angle)/Box2dEngine.RATIO);
				impulseForce.Multiply(6000);					
				box2dItem.applyImpulse(impulseForce);					
			
			
			var bullet:BulletComponent = new BulletComponent();
				bullet.lifeRemaining = gunComponent.bulletLifeTime;
				entity.addComponent(bullet);
				
				
			entity.addComponent(new CleanupComponent());			

			return entity;
		}
		
	}
}