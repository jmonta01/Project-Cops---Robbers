package com.montydigital.CopsAndRobbers.antiquated.view.props
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps;
	import com.montydigital.md2DGameEngine.view.abstract.AbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.prop.IProp;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.StDisplayObject;
	import starling.display.StImage;
	import starling.display.StQuad;
	import starling.display.StSprite;
	import starling.textures.TextureSmoothing;
	
	public class Ball extends AbstractProp implements IProp
	{
		private var _radius:Number;
		private var _position:Point;		
		
		public function Ball(radius:Number, position:Point){
			super(radius*2, radius*2, position);
			this._radius = radius;
			this._position = position;
			createB2Item();
			createStarlingItem();
		}
		
		override protected function createB2Item():void{
			var radius:Number = _radius/MDB2World.RATIO;
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(_position.x/MDB2World.RATIO, _position.y/MDB2World.RATIO, 0);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(20, 3, 1, .1); 
			box2dItem = new AbstractBox2dItem();
			box2dItem.setWithCircle(radius, initCoords, props, AbstractBox2dItem.DYNAMIC_BODY);
		}
		
		
		
		override protected function createStarlingItem():void{
			var crateBmp:Bitmap = new com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps() as Bitmap;
			crateBmp.width = this.width;
			crateBmp.height = this.height;
			
			var img:StImage = StImage.fromBitmap(crateBmp);
			img.width = this.width;
			img.height = this.height;
			img.x = - this._radius;
			img.y = - this._radius;
			img.smoothing = TextureSmoothing.TRILINEAR;
			
			var imgHolder:StSprite = new StSprite();
			imgHolder.addChild(img);			
			imgHolder.flatten();
			
			starlingItem = new AbstractStarlingItem(imgHolder);
			
			box2dItem.bodyDef.userData = starlingItem;
		}		
	}
}