package com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PhysicsComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.ScoringComponent;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.BaseBox2dItem;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.DesctructibleBox2dItem;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.vo.Box2DItemEnvPropsVO;
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	
	import starling.display.StImage;
	import starling.display.StSprite;

	public class PropFactory{
		
		
		public static function generateBox(x:Number, y:Number):Entity{
			var entity:Entity = new Entity();
			
			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_DESCRUCTIBLE_PROP;
				entity.addComponent(gameState);
			
			var position:PositionComponent = new PositionComponent();
				position.x = x;
				position.y = y;
				position.rotation = 0;
				entity.addComponent(position);
			
			var display:DisplayComponent = new DisplayComponent();
				display.layer = LayerManager.GAME_LAYER;
				display.displayObject = StImage.fromBitmap(new TempMaps.CRATE());
				display.displayObject.x = position.x;
				display.displayObject.y = position.y;
				display.displayObject.scaleX = display.displayObject.scaleY = .075;
				entity.addComponent(display);
			
			var physics:PhysicsComponent = new PhysicsComponent();		
				physics.type = EntityCreator.TYPE_BLOCK;
				var width:Number = display.displayObject.width/Box2dEngine.RATIO;
				var height:Number = display.displayObject.height/Box2dEngine.RATIO;
				var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];			
				var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(400, 3, 1, .1); 
				var box2dItem:DesctructibleBox2dItem = new DesctructibleBox2dItem();			
				box2dItem.setWithVertices(verts, position.x, position.y, 0, props, BaseBox2dItem.DYNAMIC_BODY);
				box2dItem.userData = physics;
				
				//TODO - This should be based on the number of frames in the texture animation
				box2dItem.damageIncrementer = 1/3;
				physics.item = box2dItem;			
				entity.addComponent(physics);
			
			entity.addComponent(new ScoringComponent());				
			entity.addComponent(new CleanupComponent());
				
			return entity;
		}
		
		public static function generateWall(x:Number, y:Number, width:Number, height:Number):Entity{
			var entity:Entity = new Entity();
			
			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_PROP;
				entity.addComponent(gameState);
			
			var position:PositionComponent = new PositionComponent();
				position.x = x;
				position.y = y;
				position.rotation = 0;
				entity.addComponent(position);
			
			var display:DisplayComponent = new DisplayComponent();
				display.layer = LayerManager.GAME_LAYER;
				display.displayObject = StImage.fromBitmap(new TempMaps.CRATE());
				display.displayObject.width = width;
				display.displayObject.height = height;
				display.displayObject.x = position.x;
				display.displayObject.y = position.y;
				entity.addComponent(display);
			
			var physics:PhysicsComponent = new PhysicsComponent();	
				physics.type = EntityCreator.TYPE_BOUNDARY;
				var width:Number = display.displayObject.width/Box2dEngine.RATIO;
				var height:Number = display.displayObject.height/Box2dEngine.RATIO;
				var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];				
				var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(400, 3, 1, .1); 
				var box2dItem:BaseBox2dItem = new BaseBox2dItem();			
				box2dItem.setWithVertices(verts, position.x, position.y, 0, props, BaseBox2dItem.STATIC_BODY);
				box2dItem.userData = physics;
				physics.item = box2dItem;			
				entity.addComponent(physics);
			return entity;
		}
		
		
		public static function generateTargeting():Entity{
			var entity:Entity = new Entity();
			
			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_PROP;
				entity.addComponent(gameState);	
				
			var position:PositionComponent = new PositionComponent();
				entity.addComponent(position);				
			
			var display:DisplayComponent = new DisplayComponent();	
				display.layer = LayerManager.TARGETING_LAYER;
				var crosshairs:StSprite = new StSprite();
				var img:StImage = StImage.fromBitmap(new TempMaps.CROSSHAIRS());
				img.scaleX = img.scaleY = .25;
				img.x = -img.width/2;
				img.y = -img.height/2;
				crosshairs.addChild(img);
				display.displayObject = crosshairs;
				entity.addComponent(display);
				
			return entity;
		}
			
	}
}