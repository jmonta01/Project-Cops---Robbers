package com.montydigital.CopsAndRobbers
{
	import com.montydigital.CopsAndRobbers.antiquated.initialization.GameInitializationSequencer;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.Ball;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.Block;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.Bullet;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.DestructibleBox;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.Wall;
	import com.montydigital.common.events.MDEvent;
	import com.montydigital.common.events.MDEventDispatcher;
	import com.montydigital.common.events.initializers.InitializationCompleteEvent;
	import com.montydigital.md2DGameEngine.application.IApplication;
	import com.montydigital.md2DGameEngine.controller.CentralController;
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionEvent;
	import com.montydigital.md2DGameEngine.utilities.collision.CollisionManager;
	import com.montydigital.md2DGameEngine.view.prop.Prop;
	import com.montydigital.md2DGameEngine.view.world.MDStarlingWorld;
	import com.montydigital.md2DGameEngine.view.world.MDWorld;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.StSprite;

	
	[SWF(frameRate="60", width="1200", height="600")]	
	public class Box2dTest extends Sprite implements IApplication{
		
		
		private var initalizationSequence:GameInitializationSequencer;

		private static const MAX_PROPS:int = 2;
		
		private var stageWidth:Number;
		private var stageHeight:Number;		
		
		//b2 objects
		private var world:MDWorld;		
		
		private var _starling:Starling;
		public function get starling():Starling{ return _starling; }
		public function set starling(val:Starling):void{ _starling = val; }
		
		private var _mdWorld:MDWorld;
		public function get mdWorld():MDWorld{ return _mdWorld; }
		public function set mdWorld(val:MDWorld):void{ _mdWorld = val; }
		
		private static var centralController:CentralController;
		
		private var _rootStarlingSprite:StSprite;
		public function get rootStarlingSprite():StSprite{ return _rootStarlingSprite; }
		public function set rootStarlingSprite(val:StSprite):void{ _rootStarlingSprite=val; }
		
		public function Box2dTest(){
			this.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			super();
		}
		
		private function handleAddedToStage(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			
			this.stage.quality = StageQuality.LOW;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			
			MDEventDispatcher.getInstance().addEventListener(InitializationCompleteEvent.COMPLETE, handleGameInited);			
			initalizationSequence = new GameInitializationSequencer(this, MDStarlingWorld);
			initalizationSequence.run();
			
			CollisionManager.getInstance();
		}
		
		private function handleGameInited(e:MDEvent):void{		
			rootStarlingSprite = this.starling.stage.getChildAt(0) as StSprite;
			centralController = new CentralController(this);			
			this.starling.start();					   
			
			setupEnv();
			
			addBox(500, stageHeight-5-100);
			addBox(620, stageHeight-5-100);
			addBox(740, stageHeight-5-100);
			addBox(860, stageHeight-5-100);	
			
			addBox(560, stageHeight-5-200);
			addBox(680, stageHeight-5-200);
			addBox(800, stageHeight-5-200);
			
			addBox(620, stageHeight-5-300);
			addBox(740, stageHeight-5-300);
			
			addBox(680, stageHeight-5-400);
			

			play();
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			this.stage.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		private function setupEnv():void{	
			var ground:Wall = new Wall(stageWidth-10, 5, new Point(5, stageHeight-5));
			ground.updatePosition();
			this.rootStarlingSprite.addChild(ground.getStarlingItem());
			mdWorld.addItem(ground);
			
			var rightWall:Wall = new Wall(5, stageHeight-10, new Point(stageWidth-5, 5));
			rightWall.updatePosition();
			this.rootStarlingSprite.addChild(rightWall.getStarlingItem());
			mdWorld.addItem(rightWall);
			
			var leftWall:Wall = new Wall(5, stageHeight-10, new Point(0, 5));
			leftWall.updatePosition();
			this.rootStarlingSprite.addChild(leftWall.getStarlingItem());
			mdWorld.addItem(leftWall);
			
			var ceiling:Wall = new Wall(stageWidth-10, 5, new Point(5, 0));
			ceiling.updatePosition();
			this.rootStarlingSprite.addChild(ceiling.getStarlingItem());
			mdWorld.addItem(ceiling);
		}
		
		private var totalHeight:Number;
		private function addBox(x:Number, y:Number):void{
			var block:DestructibleBox = new DestructibleBox(100, 100, new Point(x, y));
			block.updatePosition();
			this.rootStarlingSprite.addChild(block.getStarlingItem());
			mdWorld.addItem(block);
		}
		
		private function addBall():void{
			var ball:Ball = new Ball(35, new Point(740, 400));
			ball.updatePosition();
			this.rootStarlingSprite.addChild(ball.getStarlingItem());
			mdWorld.addItem(ball);
		}
		
		
		
		private function play():void{
			stage.addEventListener(Event.ENTER_FRAME, mdWorld.runLoop);
			this.starling.start();
		}
		
		private function pause():void{
			stage.removeEventListener(Event.ENTER_FRAME,  mdWorld.runLoop);
			this.starling.stop();
		}
		
		
		private function handleKeyDown(e:KeyboardEvent):void{
 			if(e.charCode == 32)
				addBall();
		}
		
		private function handleClick(e:MouseEvent):void{
			shootProjectileAt(e.stageX, e.stageY);
		}
		
		private function shootProjectileAt(x:Number, y:Number):void{
			
			var bullet:Bullet = new Bullet(Bullet.AMMO_TYPE_BAZOOKA, new Point(10, 400));
			bullet.updatePosition();
			this.rootStarlingSprite.addChild(bullet.getStarlingItem());
			mdWorld.addItem(bullet);
			bullet.shootAt(new Point(x, y));	
	}

		

		
		private function randomInt(lowVal:int, highVal:int):int{
			if ( lowVal <= highVal){
				return (lowVal + Math.floor(Math.random() * ( highVal - lowVal + 1)));
			}else{
				throw (new Error("Main.randomInt(...) lowVal exceeds highVal"));
			}
		}
		
	}
}