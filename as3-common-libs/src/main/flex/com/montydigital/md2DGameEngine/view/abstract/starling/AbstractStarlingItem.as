package com.montydigital.md2DGameEngine.view.abstract.starling
{
	import flash.geom.Point;
	
	import starling.display.StDisplayObject;
	import starling.display.StSprite;

	public class AbstractStarlingItem implements IAbstractStarlingItem{
		
		private var _stItem:StDisplayObject;
		public function get stItem():StDisplayObject{return this._stItem;}
		public function set stItem(val:StDisplayObject):void{}
		
		public function AbstractStarlingItem(stItem:StDisplayObject){
			this._stItem = stItem;
		}
		
		public function updatePosition(pos:Point, rot:Number):void{
			_stItem.x = pos.x;
			_stItem.y = pos.y;
			_stItem.rotation = rot;
		}
	}
}