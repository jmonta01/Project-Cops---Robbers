package com.montydigital.CopsAndRobbers
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="1280", height="752", frameRate="60", backgroundColor="#002143")]
	public class CopsAndRobbersMain extends Sprite
	{
		public function CopsAndRobbersMain(){
			this.addEventListener(Event.ADDED_TO_STAGE, initApp);
		}
		
		private function initApp(e:Event):void{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.removeEventListener(Event.ADDED_TO_STAGE, initApp);
		}
	}
}