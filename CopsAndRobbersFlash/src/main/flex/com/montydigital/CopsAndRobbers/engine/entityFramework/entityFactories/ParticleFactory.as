package com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories{
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CleanupComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	
	import starling.display.StImage;

	public class ParticleFactory{

		public static function generateCollisionSpark(type:String, x:Number, y:Number):Entity{
			var entity:Entity = new Entity();

			var gameState:GameStateComponent = new GameStateComponent();
				gameState.entityType = GameStateComponent.TYPE_PARTICLE;
				entity.addComponent(gameState);	
			
			var position:PositionComponent = new PositionComponent();
				position.x = x*Box2dEngine.RATIO;
				position.y = y*Box2dEngine.RATIO;
				position.rotation = 0;
				entity.addComponent(position);
			
			//TODO - use the type to dictate what kind of spark to generate
			var display:DisplayComponent = new DisplayComponent();
				display.displayObject = StImage.fromBitmap(new TempMaps.XPLOSION_TEST());
				display.displayObject.scaleX = display.displayObject.scaleY = .25;
				display.displayObject.x = position.x;
				display.displayObject.y = position.y;
				display.hasTimeout = true;
				display.timeRemaining = 5;
				entity.addComponent(display);
				
			entity.addComponent(new CleanupComponent());	
				
			return entity;
		}
		
		
	}
}