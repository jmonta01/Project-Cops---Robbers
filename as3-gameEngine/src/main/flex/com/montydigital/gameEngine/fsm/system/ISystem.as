package com.montydigital.gameEngine.fsm.system
{
	public interface ISystem
	{
		function enter():void;
		function update():void;
		function exit():void;
	}
}