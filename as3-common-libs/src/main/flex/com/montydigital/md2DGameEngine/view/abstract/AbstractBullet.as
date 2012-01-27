package com.montydigital.md2DGameEngine.view.abstract
{
	import com.montydigital.md2DGameEngine.utilities.collision.DestroyedEvent;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.geom.Point;
	
	public class AbstractBullet extends AbstractProp implements IAbstractProp{
		public function AbstractBullet(width:Number, height:Number, position:Point){
			super(width, height, position);
		}
		
		override public function updatePosition():void{
			if(starlingItem){
				var pos:Point = new Point();
				pos.x = box2dItem.body.GetPosition().x*MDB2World.RATIO;
				pos.y = box2dItem.body.GetPosition().y*MDB2World.RATIO;
				if(isSleeping()){
					new DestroyedEvent(this).dispatch();
				}else{
					starlingItem.updatePosition(pos, box2dItem.body.GetAngle());
				}
			}
		}
		
		//compares the new point to the old point, rounding to tenths for accuracy and effiecency
		private function isSleeping():Boolean{
			var cPoint:Point = new Point(
					Math.round((box2dItem.body.GetPosition().x*MDB2World.RATIO)*10)/10,
					Math.round((box2dItem.body.GetPosition().y*MDB2World.RATIO)*10)/10
				);
			var lPoint:Point = new Point(
					Math.round((starlingItem.stItem.x)*10)/10,
					Math.round((starlingItem.stItem.y)*10)/10
				);
			return (cPoint.equals(lPoint)) ? true :false;
		}
	}
}