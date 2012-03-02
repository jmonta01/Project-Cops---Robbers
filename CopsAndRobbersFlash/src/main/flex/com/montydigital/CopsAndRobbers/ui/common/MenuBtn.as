package com.montydigital.CopsAndRobbers.ui.common{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class MenuBtn extends StSprite{
		public function MenuBtn(){
			super();
			
			var base:StImage = StImage.fromBitmap(new UIAssets.ButtonBase());
			this.addChild(base);
			
//			var icon:StImage = StImage.fromBitmap(new UIAssets.MenuBtn());
//			this.addChild(icon);
		}
	}
}