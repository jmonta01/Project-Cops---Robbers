package com.montydigital.CopsAndRobbers.ui.common{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class BaseHotSpot extends StSprite{
		public function BaseHotSpot(){
			super();
			this.addChild(StImage.fromBitmap(new UIAssets.MapHotspot()));
		}
	}
}