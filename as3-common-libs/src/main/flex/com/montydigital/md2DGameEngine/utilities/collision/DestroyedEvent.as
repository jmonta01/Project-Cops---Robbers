package com.montydigital.md2DGameEngine.utilities.collision{
	import com.montydigital.common.events.MDEvent;
	import com.montydigital.md2DGameEngine.view.abstract.IAbstractProp;
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IDestructibleProp;
	
	import flash.geom.Point;
	
	public class DestroyedEvent extends MDEvent{
		
		public static const DESTROYED:String = "destroyed";
		
		public var item:IAbstractProp;
		
		public function DestroyedEvent(item:IAbstractProp){
			this.item = item;
			super(DESTROYED);
		}
	}
}