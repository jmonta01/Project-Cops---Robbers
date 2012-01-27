package com.montydigital.CopsAndRobbers.core.entityFramework{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.assets.TempMaps;
	import com.montydigital.CopsAndRobbers.core.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.core.entityFramework.vo.DisplayVO;
	import com.montydigital.CopsAndRobbers.core.entityFramework.vo.PhysicsVO;
	import com.montydigital.CopsAndRobbers.core.entityFramework.vo.PositionVO;
	import com.montydigital.CopsAndRobbers.core.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.core.physics.PhysicsEngine;
	import com.montydigital.CopsAndRobbers.core.physics.box2d.AbstractBox2dItem;
	import com.montydigital.CopsAndRobbers.core.physics.box2d.vo.Box2DItemEnvPropsVO;
	import com.montydigital.CopsAndRobbers.core.physics.box2d.vo.Box2DItemInitialCoords;
	
	import starling.display.StImage;
	
	public class EntityCreator{
		
		private var gameManager:GameManager;
		private var physicsEngine:PhysicsEngine;
		
		public function EntityCreator(gameManager:GameManager, physicsEngine:PhysicsEngine){
			this.gameManager = gameManager;
			this.physicsEngine = physicsEngine;
		}
		
		public function createBox(x:Number, y:Number):Entity{
			var box:Entity = new Entity();
			
			var position:PositionVO = new PositionVO();
			position.x = x;
			position.y = y;
			position.rotation = 0;
			box.addComponent(position);
			
			var display:DisplayVO = new DisplayVO();
			display.displayObject = StImage.fromBitmap(new TempMaps.CRATE());
			display.displayObject.scaleX = display.displayObject.scaleY = .25;
			box.addComponent(display);
			
			var physics:PhysicsVO = new PhysicsVO();
			
			var width:Number = display.displayObject.width/Box2dEngine.RATIO;
			var height:Number = display.displayObject.height/Box2dEngine.RATIO;
			var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(display.displayObject.x/Box2dEngine.RATIO, display.displayObject.y/Box2dEngine.RATIO);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(400, 3, 1, .1); 
			var box2dItem:AbstractBox2dItem = new AbstractBox2dItem();			
			box2dItem.setWithVertices(verts, initCoords, props, AbstractBox2dItem.DYNAMIC_BODY);
			physics.item = box2dItem;
			
			box.addComponent(physics);
			
			gameManager.addEntity(box);
			return box;
		}
		
		public function destroyEntity(entity:Entity):void{
			gameManager.removeEntity(entity);
		}
		
		
	}
}