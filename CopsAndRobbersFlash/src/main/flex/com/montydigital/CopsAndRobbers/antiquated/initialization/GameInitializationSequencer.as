package com.montydigital.CopsAndRobbers.antiquated.initialization
{
	import com.adobe.utils.ArrayUtil;
	import com.montydigital.CopsAndRobbers.antiquated.initialization.initializers.MDWorldInitializer;
	import com.montydigital.CopsAndRobbers.antiquated.initialization.initializers.StarlingInitializer;
	import com.montydigital.common.events.MDEvent;
	import com.montydigital.common.events.MDEventDispatcher;
	import com.montydigital.common.events.initializers.InitializationCompleteEvent;
	import com.montydigital.common.events.initializers.InitializerFaultEvent;
	import com.montydigital.common.events.initializers.InitializerSuccessEvent;
	import com.montydigital.common.initializers.IInitializationSequencer;
	import com.montydigital.common.initializers.IInitializer;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.initializers.MDGameAbstractInitializer;
	
	import flash.display.Stage;
	import flash.utils.flash_proxy;

	public class GameInitializationSequencer implements IInitializationSequencer{
		
		private var queue:Array;
		
		
		
		
		private static const STARLING:StarlingInitializer = new StarlingInitializer();
		private static const MD_WORLD:MDWorldInitializer = new MDWorldInitializer();
		
		
		private static const SEQUENCE:Array = [STARLING, MD_WORLD];
		
		/**
		 *  Sequence
		 *  1: Starling Initializer
		 *  2: MD World Initializer
		 *  3: Score Initializer
		 *  4: ...
		**/
		
		
		private var rootApplication:IApplication;
		private var rootStarlingClass:Class;
		
		private var listenerEnabled:Boolean = false;
		private var initializationComplete:Boolean = false;
		
		
		public function GameInitializationSequencer(rootApplication:IApplication, rootStarlingClass:Class){
			this.rootApplication = rootApplication;
			this.rootStarlingClass = rootStarlingClass;
		}
		
		public function run():void{
			this.queue = ArrayUtil.copyArray(SEQUENCE).reverse();
			next();
		}
		
		private function next():void{
			if(this.queue.length>0){
				if(!this.listenerEnabled){
					MDEventDispatcher.getInstance().addEventListener(InitializerSuccessEvent.SUCCESS, this.handleInitializerSuccess);
					MDEventDispatcher.getInstance().addEventListener(InitializerFaultEvent.FAULT, this.handleInitializerFault);
				}
				var nextInitializer:MDGameAbstractInitializer = this.queue.pop();
				nextInitializer.rootApplication = this.rootApplication;
				if(nextInitializer is StarlingInitializer) (nextInitializer as StarlingInitializer).rootStarlingClass = this.rootStarlingClass;
				nextInitializer.execute();
					
			}else{
				if(!this.initializationComplete){
					this.initializationComplete = true;
					MDEventDispatcher.getInstance().removeEventListener(InitializerSuccessEvent.SUCCESS, this.handleInitializerSuccess);
					MDEventDispatcher.getInstance().removeEventListener(InitializerFaultEvent.FAULT, this.handleInitializerFault);
					new InitializationCompleteEvent().dispatch();
				}
			}
		}
		
		private function handleInitializerSuccess(e:MDEvent):void{
			next();
		}
		
		private function handleInitializerFault(e:MDEvent):void{
			trace("initaliziation sequence fault");
		}
	}
}