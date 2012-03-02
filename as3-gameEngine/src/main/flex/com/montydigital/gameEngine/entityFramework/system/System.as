package com.montydigital.gameEngine.entityFramework.system
{
	import com.montydigital.gameEngine.entityFramework.GameManager;
	import com.montydigital.gameEngine.entityFramework.node.NodeList;
	
	public class System implements ISystem
	{
		public var priority:int = 0;
		public var previous : System;
		public var next : System;
		public var nodes:NodeList;
		public var nodeClass:Class;
		
		public function System()
		{
		}
		
		public function update(time:Number):void
		{
		}
		
		public function addToGame(game:GameManager):void
		{
		}
		
		public function removeFromGame(game:GameManager):void{
			nodes = null;
		}
	}
}