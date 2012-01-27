package com.montydigital.CopsAndRobbers.ui.common
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class PauseBtn extends StSprite
	{
		public function PauseBtn()
		{
			super();
			var img:StImage = StImage.fromBitmap(new UIAssets.PauseBtn());
			this.addChild(img);
		}
	}
}