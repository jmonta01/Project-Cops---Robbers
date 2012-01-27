package com.montydigital.CopsAndRobbers.antiquated.initialization.initializers
{
	import com.montydigital.common.initializers.AbstractInitializer;
	import com.montydigital.common.initializers.IInitializer;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.events.world.MDWorldReadyEvent;
	import com.montydigital.md2DGameEngine.initializers.IMDGameInitializer;
	import com.montydigital.md2DGameEngine.initializers.MDGameAbstractInitializer;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import starling.core.Starling;
	
	public class StarlingInitializer extends MDGameAbstractInitializer implements IInitializer, IMDGameInitializer{
		
		public var rootStarlingClass:Class;
		
		public function StarlingInitializer(){
			super("STARLING_INITALIZER", MDWorldReadyEvent.MD_STARLING_WORLD_READY);
		}
		
		override public function execute():void{
			super.execute();
			trace(this.getName() +" initalized");
			rootApplication.starling = new Starling(rootStarlingClass, (rootApplication as Sprite).stage);
		}
	}
}