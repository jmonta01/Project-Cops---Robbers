package com.montydigital.md2DGameEngine.view.abstract
{
	import Box2D.Dynamics.b2Fixture;
	
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.IAbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.IAbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.geom.Point;
	
	import flashx.textLayout.tlf_internal;
	
	import starling.display.StDisplayObject;
	import starling.textures.Texture;

	public class AbstractProp implements IAbstractProp{
		
		protected var width:Number=0;
		protected var height:Number=0;
		protected var position:Point=new Point(0,0);
		
		protected var box2dItem:AbstractBox2dItem;
		protected var starlingItem:AbstractStarlingItem;

		public function AbstractProp(width:Number, height:Number, position:Point){	
			this.width = width;
			this.height = height;
			this.position = position;
		}
		
		
		protected function createB2Item():void{ }
		
		protected function createStarlingItem():void{ }
		
		public function getStarlingItem():StDisplayObject{
			return starlingItem.stItem;
		}
		
		public function getB2DFixture():b2Fixture{
			return box2dItem.fixture;
		}
		
		public function destroy():void{
			starlingItem.stItem.removeFromParent(true);
			MDB2World.DestroyBody(box2dItem.body);
		}
		
		public function updatePosition():void{
			if(starlingItem){
				var pos:Point = getPosition();
				starlingItem.updatePosition(pos, box2dItem.body.GetAngle());
			}
		}
		
		public function getPosition():Point{
			var pos:Point = new Point();
			pos.x = box2dItem.body.GetPosition().x*MDB2World.RATIO;
			pos.y = box2dItem.body.GetPosition().y*MDB2World.RATIO;
			return pos;
		}
	}
}