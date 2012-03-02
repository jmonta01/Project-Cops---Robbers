package com.montydigital.CopsAndRobbers.antiquated.view.props{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.core.INavigatorContent;
	
	import starling.core.Starling;
	import starling.display.StMovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	public class AnimatedProp extends Prop implements IAnimatedProp{
		protected var fps:int;
		protected var frames:Vector.<Texture>;
		protected var mc:StMovieClip;
		protected var smoothing:String;
		protected var autoPlay:Boolean;
		
		public function AnimatedProp(width:Number, height:Number, position:Point, frames:Vector.<Texture>, fps:int=60, autoPlay:Boolean=false, smoothing:String=TextureSmoothing.TRILINEAR){
			super(width, height, position);
			this.frames = frames;
			this.smoothing = smoothing;
			this.autoPlay = autoPlay;
			this.fps = fps;
			createB2Item();
			createStarlingItem();
		}
		
		override protected function createB2Item():void{
			var width:Number = width/MDB2World.RATIO;
			var height:Number = height/MDB2World.RATIO;
			var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(position.x/MDB2World.RATIO, position.y/MDB2World.RATIO);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(400, 3, 1, .1); 
			box2dItem = new AbstractBox2dItem();
			box2dItem.setWithVertices(verts, initCoords, props, AbstractBox2dItem.DYNAMIC_BODY);
		}
		
		
		
		override protected function createStarlingItem():void{
			mc = new StMovieClip(frames, fps);
			mc.width = this.width;
			mc.height = this.height;
			mc.smoothing = smoothing;
			mc.loop = false;
			
			Starling.juggler.add(mc);
			
			starlingItem = new AbstractStarlingItem(mc);
			box2dItem.bodyDef.userData = starlingItem;
			
			mc.currentFrame = 0;
			if(autoPlay)
				play();
			else
				stop();
		}
		
		
		public function play():void{
			mc.play();
		}
		
		public function stop():void{
			mc.pause();
		}
		
		public function reset():void{
			mc.stop();
		}
		
		public function gotoAndStop(frame:int):void{
			if(frame < mc.numFrames){
				mc.currentFrame = frame;
				stop();
			}
		}
		
		public function gotoAndPlay(frame:int):void{
			if(frame < mc.numFrames){
				mc.currentFrame = frame;
				play();
			}
		}
		
		public function get currentFrame():int{ return mc.currentFrame; }
		public function set currentFrame(frame:int):void{ mc.currentFrame = frame; }
		
		public function getCurrentTexture():Texture{
			return this.mc.texture;
		}
		
		public function getInitialTexture():Texture{
			return this.mc.getFrameTexture(0);
		}
	}
}