package com.montydigital.CopsAndRobbers.ui.startMenu
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import flash.display.Bitmap;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class ShareBtn extends StSprite
	{
		public function ShareBtn(img:Bitmap){
			super();
			var image:StImage = StImage.fromBitmap(img)
			this.addChild(image);
		}
	}
}