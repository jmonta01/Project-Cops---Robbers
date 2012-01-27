package com.montydigital.CopsAndRobbers.antiquated.initialization.initializers
{
	import com.montydigital.common.initializers.AbstractInitializer;
	import com.montydigital.common.initializers.IInitializer;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.events.world.MDWorldReadyEvent;
	import com.montydigital.md2DGameEngine.initializers.IMDGameInitializer;
	import com.montydigital.md2DGameEngine.initializers.MDGameAbstractInitializer;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import starling.core.Starling;
	
	public class MDWorldInitializer extends MDGameAbstractInitializer implements IInitializer, IMDGameInitializer{
		
		
		public function MDWorldInitializer(){
			super("MD_WORLD_INITALIZER", MDWorldReadyEvent.MD_WORLD_READY);
		}
		
		override public function execute():void{
			super.execute();
			trace(this.getName() +" initalized");
			this.rootApplication.mdWorld = new MDWorld(true);
			(this.rootApplication as Sprite).stage.addChild(this.rootApplication.mdWorld);
		}
	}
}