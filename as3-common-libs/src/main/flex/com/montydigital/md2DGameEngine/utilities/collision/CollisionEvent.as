package com.montydigital.md2DGameEngine.utilities.collision{
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2Fixture;
	
	import com.montydigital.common.events.MDEvent;
	
	import flash.events.Event;
	
	public class CollisionEvent extends MDEvent{
		
		public static const BeginContact:String	= "BeginContact";
		public static const EndContact:String	= "EndContact";
		public static const PreSolve:String		= "PreSolve";
		public static const PostSolve:String	= "PostSolve";
		
		private var _fixture1:b2Fixture;
		public function set fixture1(val:b2Fixture):void{ this._fixture1 = val; }
		public function get fixture1():b2Fixture{ return this._fixture1; }
				
		private var _fixture2:b2Fixture;
		public function set fixture2(val:b2Fixture):void{ this._fixture2 = val; }
		public function get fixture2():b2Fixture{ return this._fixture2; }
		
		private var _impulse:b2ContactImpulse;
		public function set impulse(val:b2ContactImpulse):void{ this._impulse = val;}
		public function get impulse():b2ContactImpulse{ return _impulse; }
		
		public function CollisionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event{
			var evt:CollisionEvent = new CollisionEvent(type, bubbles, cancelable);
			evt.fixture1 = fixture1;
			evt.fixture2 = fixture2;
			evt.impulse = impulse;
			return evt;
		}
		
		public override function toString():String{
			return formatToString("CollisionEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}