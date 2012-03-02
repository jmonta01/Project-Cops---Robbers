package com.montydigital.CopsAndRobbers.ui.common{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class AudioBtn extends StSprite{
		public function AudioBtn(){
			super();
			
			var base:StImage = StImage.fromBitmap(new UIAssets.ButtonBase());
			this.addChild(base);
			
//			var icon:StImage = StImage.fromBitmap(new UIAssets.MuteOffBtn());
//			this.addChild(icon);
		}
	}
}