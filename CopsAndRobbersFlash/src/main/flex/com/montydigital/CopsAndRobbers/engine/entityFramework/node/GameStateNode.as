package com.montydigital.CopsAndRobbers.engine.entityFramework.node{
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.DisplayComponent;
	import com.montydigital.CopsAndRobbers.engine.entityFramework.components.GameStateComponent;
	import com.montydigital.gameEngine.entityFramework.node.Node;

	public class GameStateNode extends Node{
		public var displayComponent:DisplayComponent;
		public var gameStateComponent:GameStateComponent;
	}
}