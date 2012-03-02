package com.montydigital.CopsAndRobbers.engine.entityFramework.components{
	public class GameStateComponent{
		
		public static const TYPE_USER_CHARACTER:String = "userCharacter";
		public static const TYPE_ENEMY:String = "enemy";
		public static const TYPE_DESCRUCTIBLE_PROP:String = "destructibleProp";
		public static const TYPE_PROP:String = "prop";
		public static const TYPE_BULLET:String = "bullet";
		public static const TYPE_PARTICLE:String = "particle";
		
		public var entityType:String;		
	}
}