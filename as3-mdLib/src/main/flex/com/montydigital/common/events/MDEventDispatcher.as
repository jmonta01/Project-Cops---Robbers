package com.montydigital.common.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
//	import mx.logging.ILogger;
//	import mx.logging.Log;

	public class MDEventDispatcher
	{
		
		private var eventDispatcher:IEventDispatcher;
		
//		private var logger:ILogger = Log.getLogger("com.montydigital.events.MDEventDispatcher");
		
		
		/* Dispatch event method */
		
		public function dispatchEvent(event:*):Boolean{
			return eventDispatcher.dispatchEvent(event);
		}
		
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			eventDispatcher.removeEventListener( type, listener, useCapture );
		}		
		
		public function hasEventListener(type:String):Boolean{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean{
			return eventDispatcher.willTrigger(type);
		}
		
		
		/* Singleton Methods */
		
		private static var instance:MDEventDispatcher;
		public static function getInstance():MDEventDispatcher{
			if(!MDEventDispatcher.instance)
				MDEventDispatcher.instance = new MDEventDispatcher(new SingletonEnforcer());
			return MDEventDispatcher.instance;
		}
		
		public function MDEventDispatcher(enforcer:SingletonEnforcer){
			if(enforcer){
				eventDispatcher = new EventDispatcher();
			}else{
				throw new Error("This is a singleton, use the getInstance method");
			}
		}
	}
}
class SingletonEnforcer{}