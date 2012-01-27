package com.montydigital.CopsAndRobbers.ui.common
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class BackBtn extends StSprite
	{
		public function BackBtn()
		{
			super();
			var img:StImage = StImage.fromBitmap(new UIAssets.BackBtn());
			this.addChild(img);
		}
	}
}