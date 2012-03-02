package com.montydigital.CopsAndRobbers.ui.gamePlay.hud{
	import starling.display.StSprite;
	import starling.text.BitmapFont;
	import starling.text.StTextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class TimerDisplay extends StSprite{
		
		private var labelText:String = "Time: ";
		private var label:StTextField;
		
		public function TimerDisplay(){
			super();
			label = new StTextField(300, 50, labelText, "Poplar Std");
			label.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
			label.hAlign = HAlign.RIGHT;
			label.color = Color.WHITE; // use white to use the texture as it is (no tinting)
			this.addChild(label);
		}
		
		public function update(totalTime:Number, time:Number):void{
			var percent:Number = (totalTime-time)/totalTime;
			label.text = labelText+Math.round(percent*100)/100;
		}
	}
}