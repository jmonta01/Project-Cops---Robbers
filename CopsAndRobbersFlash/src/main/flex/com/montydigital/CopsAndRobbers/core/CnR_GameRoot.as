package com.montydigital.CopsAndRobbers.core{
	import com.montydigital.CopsAndRobbers.controller.GameController;
	import com.montydigital.CopsAndRobbers.core.states.system.levelPlay.LevelPlayBaseState;
	import com.montydigital.CopsAndRobbers.core.states.system.levelPlay.LevelPlayFailState;
	import com.montydigital.CopsAndRobbers.core.states.system.levelPlay.LevelPlayPauseState;
	import com.montydigital.CopsAndRobbers.core.states.system.levelPlay.LevelPlaySuccessState;
	import com.montydigital.CopsAndRobbers.core.states.system.levelSelect.LevelSelectCityState;
	import com.montydigital.CopsAndRobbers.core.states.system.levelSelect.LevelSelectMapState;
	import com.montydigital.CopsAndRobbers.core.states.system.startMenu.StartMenuBaseState;
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.gameEngine.GameRoot;
	import com.montydigital.gameEngine.core.stateMachine.StateMachine;
	import com.montydigital.gameEngine.core.system.Game;
	import com.montydigital.md2DGameEngine.controller.CentralController;
	
	import flash.events.Event;
	
	import starling.events.StEnterFrameEvent;
	import starling.events.StEvent;
	
	public class CnR_GameRoot extends GameRoot{
				
		public var gameFSM:StateMachine;
		
		private var controller:GameController;
		
		private var startMenu:CnR_StartMenu;
		private var citySelect:CnR_CitySelect;
		private var levelSelect:CnR_LevelSelect;
		private var levelPlay:CnR_GamePlay;
		
		private var _selectedCity:MenuCityVO;
		public function set selectedCity(val:MenuCityVO):void{ _selectedCity = val; }
		public function get selectedCity():MenuCityVO{ return _selectedCity; }
		
		private var _selectedLevel:MenuLevelVO;
		public function set selectedLevel(val:MenuLevelVO):void{ _selectedLevel = val; }
		public function get selectedLevel():MenuLevelVO{ return _selectedLevel; }		
		
		public function CnR_GameRoot(){
			super(); 
			controller = new GameController();
			this.addEventListener(StEvent.ADDED_TO_STAGE, init);
		}
		
		private function init(e:StEvent):void{
			this.removeEventListener(StEvent.ADDED_TO_STAGE, init);
			
			startMenu = new CnR_StartMenu(this);
			citySelect = new CnR_CitySelect(this);
			levelSelect = new CnR_LevelSelect(this);				
			levelPlay = new CnR_GamePlay(this);
			
			gameFSM = new StateMachine();
			
			gameFSM.addState(CnR_StartMenu.START_MENU_BASE, new StartMenuBaseState(startMenu));
			
			gameFSM.addState(CnR_CitySelect.LEVEL_SELECT_CITY, new LevelSelectCityState(citySelect));			
			gameFSM.addState(CnR_LevelSelect.LEVEL_SELECT_MAP, new LevelSelectMapState(levelSelect));
			
			gameFSM.addState(CnR_GamePlay.LEVEL_PLAY_BASE, new LevelPlayBaseState(levelPlay));
//			gameFSM.addState(CnR_GamePlay.LEVEL_PLAY_PAUSE, new LevelPlayPauseState(levelPlay));
//			gameFSM.addState(CnR_GamePlay.LEVEL_PLAY_SUCCESS, new LevelPlaySuccessState(levelPlay));
//			gameFSM.addState(CnR_GamePlay.LEVEL_PLAY_FAIL, new LevelPlayFailState(levelPlay));
			
			gameFSM.setState(CnR_StartMenu.START_MENU_BASE);			
		}
		
		
		override public function loop(e:StEnterFrameEvent):void{			
			gameFSM.update();
		}
	}
}