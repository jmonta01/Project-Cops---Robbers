package com.montydigital.CopsAndRobbers.engine.gamePlay{
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.LevelParser;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.system.*;
	import com.montydigital.CopsAndRobbers.engine.physics.PhysicsEngine;
	import com.montydigital.CopsAndRobbers.events.levelEnded.LevelEndedEvent;
	import com.montydigital.CopsAndRobbers.ui.gamePlay.Hud;
	import com.montydigital.gameEngine.display.LayerManager;
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.gameEngine.entityFramework.input.UserIntentCapture;
	import com.montydigital.gameEngine.entityFramework.system.SystemPriorities;
	
	import starling.display.StSprite;
	
	public class Game extends StSprite{
		
		public static var stageWidth:Number;
		public static var stageHeight:Number;
		
		private var levelHolder:StSprite;
		
		private var gameManager:GameManager;
		private var gameState:GameState;
		private var physicsEngine:PhysicsEngine;
		private var creator:EntityCreator;
		private var levelParser:LevelParser;
		private var userIntentCapture:UserIntentCapture;
		private var layerManager:LayerManager;
		private var hud:Hud;
		
		private var paused:Boolean=false;
		public function isPaused():Boolean{ return paused; }
		
		public function Game(){
			gameManager = new GameManager();
			gameState = new GameState();
			physicsEngine = new PhysicsEngine(PhysicsEngine.BOX2D_ENGINE);
			
			levelHolder = new StSprite();
			this.addChild(levelHolder);
			
			layerManager = new LayerManager(levelHolder);
			
			hud = new Hud(gameState);
			this.addChild(hud);
			
			userIntentCapture = new UserIntentCapture(Game.stageWidth, Game.stageHeight);
			this.addChild(userIntentCapture);
			creator = new EntityCreator(gameManager, physicsEngine, layerManager);
			levelParser = new LevelParser();
		}
		
		public function loadLevel(city:MenuCityVO, level:MenuLevelVO):void{
			clearLevel();
			prepare();
			creator.createLevel(levelParser.parseLevel(city, level));	
			
			gameState.score = 0;
			gameState.time = 0;
			//following values need to come from level data
			gameState.maxTime = 6000;
			gameState.totalRounds = 50;
		}

		
		private function prepare():void{
			gameManager.addSystem(new GameOrchestratorSystem(gameState, creator), SystemPriorities.PRE_UPDATE);
			gameManager.addSystem(new AiSystem(), SystemPriorities.PRE_UPDATE);	
			gameManager.addSystem(new TargetingSystem(userIntentCapture), SystemPriorities.UPDATE);
			gameManager.addSystem(new CameraSystem(userIntentCapture), SystemPriorities.UPDATE);
			gameManager.addSystem(new GunControlSystem(creator, gameState), SystemPriorities.UPDATE);		
			gameManager.addSystem(new BulletAgeSystem(creator), SystemPriorities.UPDATE);
			gameManager.addSystem(new PhysicsSystem(physicsEngine), SystemPriorities.MOVE);
			gameManager.addSystem(new CollisionSystem(gameState, creator), SystemPriorities.REOSLVE_COLLISIONS);
			gameManager.addSystem(new ScoringSystem(gameState), SystemPriorities.REOSLVE_COLLISIONS);
			gameManager.addSystem(new RenderSystem(layerManager, creator), SystemPriorities.RENDER);	
			gameManager.addSystem(new CleanupSystem(creator), SystemPriorities.CLEANUP);
		}
		
		public function restartLevel(city:MenuCityVO, level:MenuLevelVO):void{			
			clearLevel();
			loadLevel(city, level);
		}
		
		public function clearLevel():void{
			gameState.reset();
			gameManager.purge();
		}
		
		
		public function togglePause():void{ 
			paused = !paused; 
		}
		
		public function update():void{
			if(gameState.levelEnded){
				if(!gameState.systemNotifiedOfEnding){
					if(gameState.levelPassed)
						this.dispatchEvent(new LevelEndedEvent(LevelEndedEvent.PASSED));
					else
						this.dispatchEvent(new LevelEndedEvent(LevelEndedEvent.FAILED));
					gameState.systemNotifiedOfEnding = true;
				}
			}else{
				if(!paused) gameManager.update();				
			}
				
		}
	}
}