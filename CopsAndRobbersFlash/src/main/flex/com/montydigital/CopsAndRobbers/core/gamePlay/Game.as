package com.montydigital.CopsAndRobbers.core.gamePlay{
	import com.montydigital.CopsAndRobbers.core.entityFramework.EntityCreator;
	import com.montydigital.CopsAndRobbers.core.entityFramework.GameManager;
	import com.montydigital.CopsAndRobbers.core.entityFramework.entity.Entity;
	import com.montydigital.CopsAndRobbers.core.entityFramework.node.GameState;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.AiSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.CollisionSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.GameOrchestrator;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.PhysicsSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.RenderSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.ScoringSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.SystemPriorities;
	import com.montydigital.CopsAndRobbers.core.entityFramework.system.UserControlsSystem;
	import com.montydigital.CopsAndRobbers.core.entityFramework.vo.DisplayVO;
	import com.montydigital.CopsAndRobbers.core.physics.PhysicsEngine;
	import com.montydigital.CopsAndRobbers.data.vo.MenuCityVO;
	import com.montydigital.CopsAndRobbers.data.vo.MenuLevelVO;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	
	import starling.core.RenderSupport;
	import starling.display.StSprite;
	
	public class Game extends StSprite{
		
		private var gameManager:GameManager;
		private var gameState:GameState;
		private var physicsEngine:PhysicsEngine;
		private var creator:EntityCreator;
		
		private var paused:Boolean=false;
		public function isPaused():Boolean{ return paused; }
		
		public function Game(){
			gameManager = new GameManager();
			gameState = new GameState();
			physicsEngine = new PhysicsEngine(PhysicsEngine.BOX2D_ENGINE);
			creator = new EntityCreator(gameManager, physicsEngine);
			prepare();
		}
		
		public function loadLevel(city:MenuCityVO, level:MenuLevelVO):void{
		//	gameManager.purge();
			var boxEntity:Entity = creator.createBox(Math.random() * 200, Math.random() * 200);
			this.addChild((boxEntity.getComponent(DisplayVO) as DisplayVO).displayObject);
			start();
		}
		
		private function prepare():void{
			gameManager.addSystem(new GameOrchestrator(gameState, creator), SystemPriorities.PRE_UPDATE);
			gameManager.addSystem(new ScoringSystem(gameState), SystemPriorities.PRE_UPDATE);
			gameManager.addSystem(new AiSystem(), SystemPriorities.PRE_UPDATE);			
			gameManager.addSystem(new UserControlsSystem(), SystemPriorities.UPDATE);
			gameManager.addSystem(new PhysicsSystem(physicsEngine), SystemPriorities.MOVE);			
			gameManager.addSystem(new CollisionSystem(gameState, creator), SystemPriorities.REOSLVE_COLLISIONS);
			gameManager.addSystem(new RenderSystem(), SystemPriorities.RENDER);			
		}
		
		public function restartLevel():void{
			start();
		}
		
		private function start():void{
			gameState.score = 0;
		}
		
		public function clearLevel():void{
			gameManager.purge();
		}
		
		
		public function togglePause():void{ 
			paused = !paused; 
		}
		
		public function update():void{
			if(!paused)
				gameManager.update();
		}
	}
}