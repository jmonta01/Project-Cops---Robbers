package com.montydigital.CopsAndRobbers.ui.common
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class SettingsBtn extends StSprite
	{
		public function SettingsBtn()
		{
			super();
			var img:StImage = StImage.fromBitmap(new UIAssets.SettingsBtn())
			this.addChild(img);
		}
	}
}