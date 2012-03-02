package com.montydigital.CopsAndRobbers.engine{
	import com.montydigital.CopsAndRobbers.controller.GameController;
	import com.montydigital.CopsAndRobbers.engine.gamePlay.Game;
	import com.montydigital.CopsAndRobbers.engine.states.system.levelPlay.LevelPlayBaseState;
	import com.montydigital.CopsAndRobbers.engine.states.system.levelSelect.LevelSelectCityState;
	import com.montydigital.CopsAndRobbers.engine.states.system.levelSelect.LevelSelectMapState;
	import com.montydigital.CopsAndRobbers.engine.states.system.startMenu.StartMenuBaseState;
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.CopsAndRobbers.ui.UIAssets;
	import com.montydigital.gameEngine.fsm.GameRoot;
	import com.montydigital.gameEngine.fsm.stateMachine.StateMachine;
	
	import starling.events.StEnterFrameEvent;
	import starling.events.StEvent;
	
	public class CnR_GameRoot extends GameRoot{
				
		public var gameFSM:StateMachine;
		
//		private var controller:GameController;
		
		private var startMenu:CnR_StartMenu;
		private var citySelect:CnR_CitySelect;
		private var levelSelect:CnR_LevelSelect;
		private var levelPlay:CnR_GamePlay;

		
		public function CnR_GameRoot(){
			super(); 
			
			UIAssets.loadBitmapFonts();
			trace("FIXME - Removing mdlib - need to rethink the sharing mechanism");
//			controller = new GameController();
			this.addEventListener(StEvent.ADDED_TO_STAGE, init);
		}
		
		private function init(e:StEvent):void{
			this.removeEventListener(StEvent.ADDED_TO_STAGE, init);
			
			Game.stageWidth = this.stage.stageWidth;
			Game.stageHeight = this.stage.stageHeight;			
			
			startMenu = new CnR_StartMenu(this);
			citySelect = new CnR_CitySelect(this);
			levelSelect = new CnR_LevelSelect(this);				
			levelPlay = new CnR_GamePlay(this);
			
			gameFSM = new StateMachine();
			gameFSM.addState(CnR_StartMenu.START_MENU_BASE, new StartMenuBaseState(startMenu));
			gameFSM.addState(CnR_CitySelect.LEVEL_SELECT_CITY, new LevelSelectCityState(citySelect));			
			gameFSM.addState(CnR_LevelSelect.LEVEL_SELECT_MAP, new LevelSelectMapState(levelSelect));
			gameFSM.addState(CnR_GamePlay.LEVEL_PLAY_BASE, new LevelPlayBaseState(levelPlay));
			gameFSM.setState(CnR_StartMenu.START_MENU_BASE);			
		}
		
		
		override public function loop(e:StEnterFrameEvent):void{			
			gameFSM.update();
		}
	}
}