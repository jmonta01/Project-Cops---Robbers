package com.montydigital.CopsAndRobbers.ui{
	import flash.display.Bitmap;
	import flash.media.Camera;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.StTextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class UIAssets{
		
		//common
		[Embed(source = "/ui/shield.png")]
		public static const Shield:Class;		
		
		[Embed(source = "/ui/btns/backBtn.png")]
		public static const BackBtn:Class;
		
		//start screen		
		[Embed(source = "/ui/btns/playBtn.png")]
		public static const PlayBtn:Class;
		
		[Embed(source = "/ui/btns/gearBtn.png")]
		public static const SettingsBtn:Class;
		
		[Embed(source = "/ui/btns/facebookBtn.png")]
		public static const FacebookBtn:Class;
		
		[Embed(source = "/ui/btns/twitterBtn.png")]
		public static const TwitterBtn:Class;

		//options menu
		[Embed(source = "/ui/optionsMenuBackground.png")]
		public static const OptionsMenuBackground:Class;
		
		[Embed(source = "/ui/btns/saveBtn.png")]
		public static const SaveBtn:Class;
		
		[Embed(source = "/ui/btns/cancelBtn.png")]
		public static const CancelBtn:Class;
		
		//city select menu
		[Embed(source = "/ui/mapBig.png")]
		public static const MapBig:Class;
		
		[Embed(source = "/ui/mapHotspot.png")]
		public static const MapHotspot:Class;	
		
		//map select menu
		[Embed(source = "/ui/mapChicago.png")]
		public static const MapChicago:Class;
				
		[Embed(source = "/ui/mapLabel.png")]
		public static const MapLabel:Class;
		
		
		//game play assets
		[Embed(source = "/ui/btns/pauseBtn.png")]
		public static const PauseBtn:Class;
		
		[Embed(source = "/ui/stopWatch.png")]
		public static const StopWatch:Class;
		
		[Embed(source = "/ui/levelEndbackground.png")]
		public static const LevelEndbackground:Class;
		

		//buttons
		[Embed(source = "/ui/btns/buttonBase.png")]
		public static const ButtonBase:Class;
		
		[Embed(source = "/ui/btns/restartBtn.png")]
		public static const RestartBtn:Class;
		
		[Embed(source = "/ui/btns/menuBtn.png")]
		public static const MenuBtn:Class;
		
		[Embed(source = "/ui/btns/muteOffBtn.png")]
		public static const MuteOffBtn:Class;
		
		[Embed(source = "/ui/btns/muteOnBtn.png")]
		public static const MuteOnBtn:Class;		
		
		
		//font
		
		[Embed(source="/fonts/poplar.fnt", mimeType="application/octet-stream")]
		private static const PoplarXml:Class;
		
		[Embed(source = "/fonts/poplar.png")]
		private static const PoplarTexture:Class;
		
		
		
		// Texture cache
		
		private static var sTextures:Dictionary = new Dictionary();
		private static var sSounds:Dictionary = new Dictionary();
		private static var sTextureAtlas:TextureAtlas;
		private static var sBitmapFontsLoaded:Boolean;
		
		public static function getTexture(name:String):Texture{
			if (sTextures[name] == undefined){
				var data:Object = new UIAssets[name]();
				if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap);
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray);
			}			
			return sTextures[name];
		}
		
		public static function getSound(name:String):Sound{
			var sound:Sound = sSounds[name] as Sound;
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}
		
//		public static function getTextureAtlas():TextureAtlas
//		{
//			if (sTextureAtlas == null){
//				var texture:Texture = getTexture("AtlasTexture");
//				var xml:XML = XML(new AtlasXml());
//				sTextureAtlas = new TextureAtlas(texture, xml);
//			}
//			
//			return sTextureAtlas;
//		}
		
		public static function loadBitmapFonts():void{
			if (!sBitmapFontsLoaded){
				var texture:Texture = getTexture("PoplarTexture");
				var xml:XML = XML(new PoplarXml());
				StTextField.registerBitmapFont(new BitmapFont(texture, xml));
				sBitmapFontsLoaded = true;
			}
		}
		
//		public static function prepareSounds():void{
//			sSounds["Step"] = new StepSound();   
//		}
	}
	
}