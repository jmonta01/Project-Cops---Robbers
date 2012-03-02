package com.montydigital.CopsAndRobbers.antiquated.view.props
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.montydigital.md2DGameEngine.utilities.collision.DestroyedEvent;
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.CopsAndRobbers.antiquated.view.props.IProp;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.StDisplayObject;
	import starling.display.StImage;
	import starling.display.StMovieClip;
	import starling.display.StQuad;
	import starling.display.StSprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class ParticleProp extends AbstractProp implements IProp{
		
		private var texture:Texture;
		
		public function ParticleProp(texture:Texture, width:Number, height:Number, position:Point, force:Number){
			this.texture = texture;
			super(width, height, position);
			createB2Item();
			createStarlingItem();
			applyImpulse(force);
		}
		
		override protected function createB2Item():void{
			var width:Number = width/MDB2World.RATIO;
			var height:Number = height/MDB2World.RATIO;
			var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(position.x/MDB2World.RATIO, position.y/MDB2World.RATIO);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(400, 3, 1, .1); 
			box2dItem = new AbstractBox2dItem();
			box2dItem.setWithVertices(verts, initCoords, props, AbstractBox2dItem.STATIC_BODY);
		}
		
		
		
		override protected function createStarlingItem():void{		
			var textures:Vector.<Texture> = new Vector.<Texture>();		
			textures.push(texture);
			var mc:StMovieClip = new StMovieClip(textures);		
			starlingItem = new AbstractStarlingItem(mc);			
			box2dItem.bodyDef.userData = starlingItem;
		}
		
		private function applyImpulse(force:Number):void{
			var explosionForce:Number = Math.min(3, Math.max(force, 7)); 
			var angle:Number = (Math.random()*360)*(Math.PI/180);
			var impulseForce:b2Vec2 = new b2Vec2(Math.cos(angle), Math.sin(angle));
			impulseForce.Multiply(40*explosionForce);
			box2dItem.body.ApplyForce(impulseForce, box2dItem.body.GetWorldCenter());
		}
		
		override public function updatePosition():void{
			if(starlingItem){
				var pos:Point = new Point();
				pos.x = box2dItem.body.GetPosition().x*MDB2World.RATIO;
				pos.y = box2dItem.body.GetPosition().y*MDB2World.RATIO;
				if(isSleeping()){
				//	new DestroyedEvent(this).dispatch();
				}else{
					starlingItem.updatePosition(pos, box2dItem.body.GetAngle());
				}
			}
		}
		
		//compares the new point to the old point, rounding to tenths for accuracy and effiecency
		private function isSleeping():Boolean{
			var cPoint:Point = new Point(
				Math.round((box2dItem.body.GetPosition().x*MDB2World.RATIO)*10)/10,
				Math.round((box2dItem.body.GetPosition().y*MDB2World.RATIO)*10)/10
			);
			var lPoint:Point = new Point(
				Math.round((starlingItem.stItem.x)*10)/10,
				Math.round((starlingItem.stItem.y)*10)/10
			);
			return (cPoint.equals(lPoint)) ? true :false;
		}

	}
}