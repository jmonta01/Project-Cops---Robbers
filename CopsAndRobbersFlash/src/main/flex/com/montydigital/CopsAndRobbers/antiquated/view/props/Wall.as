package com.montydigital.CopsAndRobbers.antiquated.view.props
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps;
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.StImage;
	import starling.display.StQuad;
	import starling.textures.TextureSmoothing;
	
	public class Wall extends AbstractProp implements IProp{

		
		public function Wall(width:Number, height:Number, position:Point){
			super(width, height, position);
			createB2Item();
			createStarlingItem();
		}
		
		override protected function createB2Item():void{
			var width:Number = width/MDB2World.RATIO;
			var height:Number = height/MDB2World.RATIO;
			var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(position.x/MDB2World.RATIO, position.y/MDB2World.RATIO);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(0, .6, .5, .2); 
			box2dItem = new AbstractBox2dItem()
			box2dItem.setWithVertices(verts, initCoords, props, AbstractBox2dItem.STATIC_BODY);
		}
		
		override protected function createStarlingItem():void{
			var crateBmp:Bitmap = new com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps() as Bitmap;
			crateBmp.width = this.width;
			crateBmp.height = this.height;
			
			var img:StImage = StImage.fromBitmap(crateBmp);
			img.width = this.width;
			img.height = this.height;		
			img.smoothing = TextureSmoothing.TRILINEAR;
			starlingItem = new AbstractStarlingItem(img);
		}	
	}
}