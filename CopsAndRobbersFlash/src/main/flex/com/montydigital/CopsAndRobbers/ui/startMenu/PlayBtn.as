package com.montydigital.CopsAndRobbers.ui.startMenu
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	
	import flash.display.Bitmap;
	
	import starling.display.StButton;
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.textures.Texture;
	
	public class PlayBtn extends StSprite
	{
		public function PlayBtn()
		{			
			super();
			var img:StImage = StImage.fromBitmap(new UIAssets.PlayBtn())
			this.addChild(img);
		//	this.scaleX = this.scaleY = .5;
		}
	}
}