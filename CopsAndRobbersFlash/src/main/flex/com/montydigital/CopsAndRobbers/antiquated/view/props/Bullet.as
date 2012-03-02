package com.montydigital.CopsAndRobbers.antiquated.view.props
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps;
	import com.montydigital.md2DGameEngine.view.abstract.AbstractBullet;
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
	
	public class Bullet extends AbstractBullet implements IProp
	{
		public static const AMMO_TYPE_BB:int = 0;
		public static const AMMO_TYPE_22:int = 1;
		public static const AMMO_TYPE_38:int = 2;
		public static const AMMO_TYPE_45:int = 3;
		public static const AMMO_TYPE_12GAUGE:int = 4;
		public static const AMMO_TYPE_BAZOOKA:int = 5;
		
		private var _mass:Number;
		private var _forceMultiplier:int = 0;
		
		public function Bullet(type:int, position:Point){
			super(width, height, position);
			handleAmmoTypeSet(type);
			createB2Item();
			createStarlingItem();
		}
		
		private function handleAmmoTypeSet(type:int):void{
			switch(type){
				case AMMO_TYPE_BB:
						this.width = 2;
						this.height = 2;
						_mass = .05;
						_forceMultiplier = 50;
					break;
				case AMMO_TYPE_22:
						this.width = 3;
						this.height = 2;
						_mass = .07;
						_forceMultiplier = 75;
					break;
				case AMMO_TYPE_38:
						this.width = 4;
						this.height = 4;
						_mass = .38;
						_forceMultiplier = 125;
					break;
				case AMMO_TYPE_45:
						this.width = 7;
						this.height = 7;
						_mass = .45;
						_forceMultiplier = 150;
					break;
				case AMMO_TYPE_12GAUGE:
						this.width = 12;
						this.height = 10;
						_mass = 1;
						_forceMultiplier = 200;
					break;
				case AMMO_TYPE_BAZOOKA:
						this.width = 40;
						this.height = 20;
						_mass = 12;
						_forceMultiplier = 500;
					break;
			}
		}
		
		override protected function createB2Item():void{
			var width:Number = width/MDB2World.RATIO;
			var height:Number = height/MDB2World.RATIO;
			var verts:Array = [new b2Vec2(0, 0), new b2Vec2(width, 0), new b2Vec2(width, height), new b2Vec2(0, height)];
			
			var initCoords:Box2DItemInitialCoords = new Box2DItemInitialCoords(position.x/MDB2World.RATIO, position.y/MDB2World.RATIO);
			var props:Box2DItemEnvPropsVO = new Box2DItemEnvPropsVO(_mass, 5, 1, .1, true); 
			box2dItem = new AbstractBox2dItem()
			box2dItem.setWithVertices(verts, initCoords, props, AbstractBox2dItem.DYNAMIC_BODY);
			//box2dItem.setWithCircle(5, initCoords, props, AbstractBox2dItem.DYNAMIC_BODY);
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
			
			box2dItem.bodyDef.userData = starlingItem;
		}	
		
		public function shootAt(target:Point):void{
			var distX:Number = (target.x - this.position.x); //
			var distY:Number = (target.y - this.position.y); //mouseY - bulletOriginY
			var angle:Number = Math.atan2(distY, distX);
			
			var impulseForce:b2Vec2 = new b2Vec2(Math.cos(angle)/MDB2World.RATIO, Math.sin(angle)/MDB2World.RATIO);
			//impulseForce.Normalize();
			impulseForce.Multiply(_forceMultiplier*40);			
			box2dItem.body.ApplyImpulse(impulseForce, box2dItem.body.GetWorldCenter());
		}
	}
}