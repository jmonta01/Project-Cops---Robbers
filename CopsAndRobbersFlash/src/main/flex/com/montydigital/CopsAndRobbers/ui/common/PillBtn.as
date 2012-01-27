package com.montydigital.CopsAndRobbers.ui.common
{
	import flash.display.Bitmap;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	
	public class PillBtn extends StSprite
	{
		public function PillBtn(img:Bitmap){
			super();
			var image:StImage = StImage.fromBitmap(img)
			this.addChild(image);
		}
	}
}