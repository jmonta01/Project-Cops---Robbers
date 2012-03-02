package com.montydigital.gameEngine.entityFramework.system
{
	public class SystemPriorities
	{
		public static const PRE_UPDATE : int = 1;
		public static const UPDATE : int = 2;
		public static const MOVE : int = 3;
		public static const REOSLVE_COLLISIONS : int = 4;
		public static const RENDER : int = 5;
		public static const CLEANUP : int = 6;
	}
}