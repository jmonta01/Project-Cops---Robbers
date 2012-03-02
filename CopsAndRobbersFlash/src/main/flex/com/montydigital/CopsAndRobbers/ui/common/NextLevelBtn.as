package com.montydigital.CopsAndRobbers.ui.common
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class NextLevelBtn extends StSprite
	{
		public function NextLevelBtn()
		{
			super();
			
			var base:StImage = StImage.fromBitmap(new UIAssets.ButtonBase());
			this.addChild(base);

//			var icon:StImage = StImage.fromBitmap(new UIAssets.NextBtn());
//			this.addChild(icon);

		}
	}
}