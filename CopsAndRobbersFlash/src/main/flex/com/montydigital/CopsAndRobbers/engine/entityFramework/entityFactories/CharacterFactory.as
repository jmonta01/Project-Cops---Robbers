package com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories
{
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GunControlComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.gameEngine.utility.MeasurementUtil;
	
	import starling.display.StImage;
	import starling.textures.TextureSmoothing;

	public class CharacterFactory
	{
		public static function generateShooter(x:Number, y:Number):Entity{
			var entity:Entity = new Entity();
			
			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_USER_CHARACTER;
				entity.addComponent(gameState);			
			
			var position:PositionComponent = new PositionComponent();
				position.x = x;
				position.y = y;
				entity.addComponent(position);
			
			var display:DisplayComponent = new DisplayComponent();
				display.layer = LayerManager.GAME_LAYER;
				var map:StImage = StImage.fromBitmap(new TempMaps.SHOOTER_BASE());
				map.smoothing = TextureSmoothing.TRILINEAR;
				display.displayObject =  map;
				display.displayObject.x = position.x;
				display.displayObject.y = position.y;
				display.displayObject.scaleX = display.displayObject.scaleY = .4; 
				entity.addComponent(display);
				
			var userControlComponent:TargetingComponent = new TargetingComponent();
				entity.addComponent(userControlComponent);
			
			var gun:GunComponent = new GunComponent();
				gun.bulletLifeTime = 75;
				gun.minimumShotInterval = .3;
				gun.currentBulletsInClip = 10;
				gun.totalBulletsInClip = 10;
				gun.offsetFromParent.x = 147;
				gun.offsetFromParent.y = 68;
				entity.addComponent(gun);
				
			var gunControls:GunControlComponent = new GunControlComponent();
				entity.addComponent(gunControls);
				
				entity.addComponent(new CleanupComponent());
			
			return entity;
		}
	}
}