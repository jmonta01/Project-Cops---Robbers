package com.montydigital.CopsAndRobbers.core
{
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.CopsAndRobbers.events.social.SocialEvent;
	import com.montydigital.CopsAndRobbers.ui.startMenu.OptionsMenu;
	import com.montydigital.CopsAndRobbers.ui.startMenu.PlayBtn;
	import com.montydigital.CopsAndRobbers.ui.common.SettingsBtn;
	import com.montydigital.CopsAndRobbers.ui.startMenu.ShareBtn;
	import com.montydigital.gameEngine.core.stateMachine.StateMachine;
	import com.montydigital.gameEngine.core.system.ISystem;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import starling.display.StImage;
	import starling.display.StSprite;
	import starling.events.StEvent;
	import starling.events.StTouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class CnR_StartMenu extends StSprite implements ISystem
	{
		
		public static const START_MENU_BASE:String = "startMenuBase";
		
		private var gameRoot:CnR_GameRoot;
		
		private var optionsOpen:Boolean=false;
		
		private var shield:StImage;
		private var playBtn:PlayBtn;
		private var settingsBtn:SettingsBtn;
		private var facebookBtn:ShareBtn;
		private var twitterBtn:ShareBtn;
		
		private var optionsMenu:OptionsMenu;
		
		public function CnR_StartMenu(root:CnR_GameRoot){
			gameRoot = root;
			
			shield = StImage.fromBitmap(new UIAssets.Shield());
			shield.x = gameRoot.stage.stageWidth/2 - shield.width/2;
			shield.y = gameRoot.stage.stageHeight/2-shield.height/2;
			
			playBtn = new PlayBtn();
			playBtn.x = gameRoot.stage.stageWidth/2 - playBtn.width/2;
			playBtn.y = gameRoot.stage.stageHeight/2-playBtn.height/2;
			playBtn.touchable = true;
			playBtn.addEventListener(StTouchEvent.TOUCH, handlePlayBtnClick);
			
			settingsBtn = new SettingsBtn();
			settingsBtn.x = 20;
			settingsBtn.y = gameRoot.stage.stageHeight - settingsBtn.height - 20;
			settingsBtn.touchable = true;
			settingsBtn.addEventListener(StTouchEvent.TOUCH, handleSettingsBtnClick);
			
			facebookBtn = new ShareBtn(new UIAssets.FacebookBtn());
			facebookBtn.x = gameRoot.stage.stageWidth - facebookBtn.width - 20;
			facebookBtn.y = gameRoot.stage.stageHeight - facebookBtn.height - 20;
			facebookBtn.touchable = true;
			facebookBtn.addEventListener(StTouchEvent.TOUCH, handleShareBtnClick);
			
			twitterBtn = new ShareBtn(new UIAssets.TwitterBtn());
			twitterBtn.x = gameRoot.stage.stageWidth - twitterBtn.width - facebookBtn.width - 40;
			twitterBtn.y = gameRoot.stage.stageHeight - twitterBtn.height - 20;
			twitterBtn.touchable = true;
			twitterBtn.addEventListener(StTouchEvent.TOUCH, handleShareBtnClick);
			
			
			optionsMenu = new OptionsMenu();
			optionsMenu.x = 20;
			optionsMenu.y = gameRoot.stage.stageHeight/2 - optionsMenu.height/2;
			optionsMenu.addEventListener(OptionsMenu.CLOSE_EVENT, toggleOptionsMenu);
		}
		
		public function enter():void{
			gameRoot.addChild(this);
			this.addChild(shield);
			this.addChild(playBtn);
			this.addChild(settingsBtn);
			this.addChild(facebookBtn);
			this.addChild(twitterBtn);
		}
		
		public function update():void{}
		
		public function toggleOptionsMenu(e:StEvent=null):void{
			optionsOpen = !optionsOpen;
			if(optionsOpen){
				openOptionsMenu();
			}else{
				closeOptionsMenu();
			}
		}
		
		private function openOptionsMenu():void{
			this.addChild(optionsMenu);
		}
		
		private function closeOptionsMenu():void{
			this.removeChild(optionsMenu);
		}
		
		public function exit():void{
			gameRoot.removeChild(this);
			this.removeChild(shield);
			this.removeChild(playBtn);
			this.removeChild(settingsBtn);
			this.removeChild(facebookBtn);	
			this.removeChild(twitterBtn);
		}
		
		private function handlePlayBtnClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(playBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED)
				gameRoot.gameFSM.setState(CnR_CitySelect.LEVEL_SELECT_CITY);
		}
		
		private function handleSettingsBtnClick(e:StTouchEvent):void{
			var touch:Touch = e.getTouch(settingsBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED)
				toggleOptionsMenu();
		}
		
		private function handleShareBtnClick(e:StTouchEvent):void{
			var touch:Touch;
			touch = e.getTouch(facebookBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED)
				new SocialEvent(SocialEvent.FACEBOOK).dispatch();
			touch = e.getTouch(twitterBtn);
			if(touch && touch.phase ==  TouchPhase.ENDED)
				new SocialEvent(SocialEvent.TWITTER).dispatch();
		}
	}
}