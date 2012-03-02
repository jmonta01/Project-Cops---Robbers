package com.montydigital.CopsAndRobbers.engine.physics.box2d{
	import Box2D.Common.Math.b2Vec2;

	public class DesctructibleBox2dItem extends BaseBox2dItem{
		
		private var damage:Number=0;
		public var damageIncrementer:Number;
		public var forceThreshold:Number=40;
		public var destroyed:Boolean = false;

		
		private var adjustedForce:Number;
		private var multiplier:Number; 
		public function applyDestructibleForce(force:Number, contactPoint:b2Vec2):void{
			adjustedForce = (force > forceThreshold) ? force - forceThreshold : 0;

			if(adjustedForce > 0){
				multiplier = Math.floor((adjustedForce/forceThreshold)*10)/10; 
				damage += damageIncrementer*multiplier;
//				trace("damage: ", damage);
				if(damage > 1 && !destroyed){
//					trace("item totally destroyed, remove from game");
					destroyed = true;
				}
			}

		}
	}
}