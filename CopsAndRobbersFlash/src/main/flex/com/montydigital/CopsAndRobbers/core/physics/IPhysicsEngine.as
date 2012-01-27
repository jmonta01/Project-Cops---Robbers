package com.montydigital.CopsAndRobbers.core.physics
{
	public interface IPhysicsEngine
	{
		function start():void;
		function togglePause():void;
		function update():void;
		function stop():void;
	}
}