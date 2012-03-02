package com.montydigital.CopsAndRobbers.ui.gamePlay.hud{
	import starling.display.StSprite;
	import starling.text.BitmapFont;
	import starling.text.StTextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class RoundsDisplay extends StSprite{
		
		private var rounds:int = 0;
		private var labelText:String = "Rounds: ";
		private var label:StTextField;
		
		public function RoundsDisplay(){
			super();
			label = new StTextField(300, 50, labelText, "Poplar Std");
			label.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
			label.hAlign = HAlign.LEFT;
			label.color = Color.WHITE; // use white to use the texture as it is (no tinting)
			this.addChild(label);
		}
		
		public function update(rounds:int):void{
			this.rounds = rounds;
			label.text = labelText+this.rounds;
		}
	}
}