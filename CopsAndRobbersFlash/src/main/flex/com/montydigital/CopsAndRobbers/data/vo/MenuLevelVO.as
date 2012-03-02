package com.montydigital.CopsAndRobbers.data.vo{
	import flash.geom.Point;
	
	public class MenuLevelVO{
		
		public var id:String;
		public var label:String;
		public var coords:Point;

		public function MenuLevelVO(id:String, label:String,coords:Point){
			this.id = id;
			this.label = label;
			this.coords = coords;
		}
		
		public static function deserialize(obj:Object):MenuLevelVO{
			return new MenuLevelVO(obj.id, obj.label, new Point(obj.x, obj.y));
		}
	}
}