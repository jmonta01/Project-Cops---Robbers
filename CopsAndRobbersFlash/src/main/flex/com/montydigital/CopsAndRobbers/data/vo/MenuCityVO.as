package com.montydigital.CopsAndRobbers.data.vo{
	import flash.geom.Point;
	
	public class MenuCityVO{
		
		public var id:String;
		public var label:String;
		public var coords:Point;
		public var flagDirection:String;
		public var enabled:Boolean;
		public var levels:Array;
		
		public function MenuCityVO(id:String, label:String,coords:Point, flagDirection:String, enabled:Boolean, levels:Array){
			this.id = id;
			this.label = label;
			this.coords = coords;
			this.flagDirection = flagDirection;
			this.enabled = enabled;
			this.levels = levels;
		}
		
		public static function deserialize(obj:Object):MenuCityVO{
			var levels:Array = [];
			for each(var level:Object in obj.levels){
				levels.push(MenuLevelVO.deserialize(level));
			}
			return new MenuCityVO(obj.id, obj.label, new Point(obj.x, obj.y), obj.flagDirection, obj.enabled, levels);
		}
	}
}