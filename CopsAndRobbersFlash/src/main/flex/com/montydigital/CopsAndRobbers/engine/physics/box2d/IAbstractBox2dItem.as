package com.montydigital.CopsAndRobbers.engine.physics.box2d
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.montydigital.CopsAndRobbers.engine.physics.Box2dEngine;
	import com.montydigital.CopsAndRobbers.engine.physics.box2d.vo.Box2DItemEnvPropsVO;
	
	import flash.geom.Point;

	public interface IAbstractBox2dItem{
		
		//b2 properties
		function get envProps():Box2DItemEnvPropsVO;
		function set envProps(val:Box2DItemEnvPropsVO):void;
		
		//generic position attributes
		function get x():Number;
		function get y():Number;
		function get rotation():Number;

		//generator functions
		function setWithVertices(vertices:Array, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=2):void;
		function setWithCircle(radius:Number, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void
		function setWithSquare(width:Number, height:Number, x:Number, y:Number, rotation:Number, envProps:Box2DItemEnvPropsVO, bodyType:int=-1):void;
	}
}