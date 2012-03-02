package com.montydigital.CopsAndRobbers.ui.common{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class RestartBtn extends StSprite{
		public function RestartBtn(){
			super();
			
			var base:StImage = StImage.fromBitmap(new UIAssets.ButtonBase());
			this.addChild(base);
			
			var icon:StImage = StImage.fromBitmap(new UIAssets.RestartBtn());
			icon.x = base.width/2 - icon.width/2;
			icon.y = base.height/2 - icon.height/2;
			this.addChild(icon);
		}
	}
}