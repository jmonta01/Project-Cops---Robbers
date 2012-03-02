package com.montydigital.CopsAndRobbers.engine.entityFramework.entityFactories{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.CameraComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.PositionComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.TargetingComponent;
	import com.montydigital.gameEngine.entityFramework.entity.Entity;
	
	import flash.geom.Rectangle;
	
	import starling.display.StSprite;

	public class CameraFactory{
		public static function createGameCamera(levelHolder:StSprite):Entity{
			var entity:Entity = new Entity();

			var camera:CameraComponent = new CameraComponent();
				camera.view = levelHolder;
				entity.addComponent(camera);

			return entity;
		}
		
	}
}