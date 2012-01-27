package com.montydigital.md2DGameEngine.view.abstract.box2d
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.montydigital.md2DGameEngine.view.world.MDB2World;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemEnvPropsVO;
	import com.montydigital.md2DGameEngine.vo.box2d.Box2DItemInitialCoords;
	
	import flash.geom.Point;

	public interface IAbstractBox2dItem
	{
		// b2 core objects
		function get bodyDef():b2BodyDef;
		function set bodyDef(val:b2BodyDef):void;
		
		function get body():b2Body;
		function set body(val:b2Body):void;
		
//		function get shape():b2PolygonShape;
//		function set shape(val:b2PolygonShape):void;
		
		function get fixtureDef():b2FixtureDef
		function set fixtureDef(val:b2FixtureDef):void;
		
		//b2 properties
		function get density():Number;
		function set density(val:Number):void;
		
		function get friction():Number;
		function set friction(val:Number):void;
		
		function get restitution():Number;
		function set restitution(val:Number):void;		
		
		function setWithVertices(vertices:Array, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=2):void;
		function setWithCircle(radius:Number, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void
		function setWithSquare(width:Number, height:Number, initialCoords:Box2DItemInitialCoords, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void;
		
	}
}