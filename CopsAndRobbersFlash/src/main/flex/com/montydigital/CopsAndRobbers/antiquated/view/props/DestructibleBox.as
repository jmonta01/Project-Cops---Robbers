package com.montydigital.CopsAndRobbers.antiquated.view.props
{
	import Box2D.Common.Math.b2Vec2;
	
	import com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps;
	import com.montydigital.md2DGameEngine.view.abstract.IAbstractProp;
	import com.montydigital.md2DGameEngine.view.abstract.box2d.AbstractBox2dItem;
	import com.montydigital.md2DGameEngine.view.abstract.starling.AbstractStarlingItem;
	import com.montydigital.md2DGameEngine.view.prop.AnimatedProp;
	import com.montydigital.md2DGameEngine.view.prop.DestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IDestructibleProp;
	import com.montydigital.md2DGameEngine.view.prop.IProp;
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.StMovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	public class DestructibleBox extends DestructibleProp{
			
		public function DestructibleBox(width:Number, height:Number, position:Point){
			
			var _texture:Texture = Texture.fromBitmap(new com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps() as Bitmap);
			var _descriptorXML:XML = XML(new com.montydigital.CopsAndRobbers.antiquated.view.assets.TempMaps());
			var _textureAtlas:TextureAtlas = new TextureAtlas(_texture, _descriptorXML); 
			var _frames:Vector.<Texture> = _textureAtlas.getTextures();	
			
			super(width, height, position, _frames);
		}
		

	}
}