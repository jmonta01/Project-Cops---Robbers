package com.montydigital.CopsAndRobbers.ui.gamePlay.hud{
	import starling.display.StSprite;
	import starling.text.BitmapFont;
	import starling.text.StTextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class HighScoreDisplay extends StSprite{
		
		private var score:int = 0;
		private var labelText:String = "Highscore: ";
		private var label:StTextField;
		
		public function HighScoreDisplay(){
			super();
			label = new StTextField(300, 50, labelText, "Poplar Std");
			label.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
			label.hAlign = HAlign.RIGHT;
			label.color = Color.WHITE; // use white to use the texture as it is (no tinting)
			this.addChild(label);
		}
		
		public function update(score:int):void{
			this.score = score;
			label.text = labelText+this.score;
		}
	}
}