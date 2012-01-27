package com.montydigital.md2DGameEngine.view.prop{
	import com.montydigital.md2DGameEngine.utilities.collision.DestroyedEvent;
	
	import flash.geom.Point;
	
	import starling.textures.Texture;
	
	public class DestructibleProp extends AnimatedProp implements IDestructibleProp{
		
		protected var damage:Number=0;
		protected var damageIncrementer:Number;
		protected var forceThreshold:Number=60;
		public var lastForceMultiplierApplied:Number;
		private var destroyed:Boolean = false;

		
		public function DestructibleProp(width:Number, height:Number, position:Point, frames:Vector.<Texture>){
			super(width, height, position, frames);
			damageIncrementer = 1 / frames.length;
		}
		
		public function applyForce(force:Number):void{
			var adjustedForce:Number = (force > forceThreshold) ? force - forceThreshold : 0;
						
			var oldFrame:int = this.currentFrame;
			var newFrame:int = oldFrame;
			if(adjustedForce > 0){
				var multiplier:Number = Math.floor((adjustedForce/forceThreshold)*10)/10; 
				damage += damageIncrementer*multiplier;
				lastForceMultiplierApplied = multiplier;
				if(damage < 1){
					newFrame = Math.round(damage*frames.length);
					this.gotoAndStop(newFrame);
				}else{
					if(!destroyed){
						new DestroyedEvent(this).dispatch();
						destroyed = true;
					}
				}
			}
		}
	}
}