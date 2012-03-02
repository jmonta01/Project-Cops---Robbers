package com.montydigital.gameEngine.entityFramework.system
{
	import com.montydigital.gameEngine.entityFramework.GameManager;

	public interface ISystem
	{
		function update(time:Number):void;
		function addToGame(game:GameManager):void;
		function removeFromGame(game:GameManager):void;
	}
}