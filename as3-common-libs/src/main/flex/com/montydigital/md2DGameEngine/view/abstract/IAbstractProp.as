package com.montydigital.md2DGameEngine.view.abstract{
	import Box2D.Dynamics.b2Fixture;
	
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	
	import starling.display.StDisplayObject;

	public interface IAbstractProp{
		function updatePosition():void;
		function getPosition():Point;
		function getStarlingItem():StDisplayObject;
		function destroy():void;
		function getB2DFixture():b2Fixture;
	}
}