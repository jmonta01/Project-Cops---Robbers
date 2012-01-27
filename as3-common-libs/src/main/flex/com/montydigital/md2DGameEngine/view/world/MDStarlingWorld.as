package com.montydigital.md2DGameEngine.view.world
{
	import com.montydigital.md2DGameEngine.events.world.MDWorldReadyEvent;
	
	import starling.display.StSprite;
	import starling.events.StEvent;

	public class MDStarlingWorld extends StSprite{
		

//		public function addItem():void{			
//			var quad:Quad = new Quad(150, 150, Math.random()*0xFFFFFF);
//			quad.pivotX = 150 / 2;
//			quad.pivotY = 150 / 2;
//			quad.x = quad.y = 300
//			addChild(quad);
//		}
		
		
		public function MDStarlingWorld(){	
			this.addEventListener(StEvent.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		private function handleAddedToStage(e:StEvent):void{
			this.removeEventListener(StEvent.ADDED_TO_STAGE, handleAddedToStage);
			new MDWorldReadyEvent(MDWorldReadyEvent.MD_STARLING_WORLD_READY).dispatch();
		}
	}
}