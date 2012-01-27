package com.montydigital.gameEngine.core.states
{
	import com.montydigital.gameEngine.core.actor.IActor;

	public class ActorState implements IState
	{
		
		private var actor:IActor;
		
		public function ActorState(actor:IActor)
		{
			this.actor = actor;
		}
		
		public function enter():void
		{
		}
		
		public function update():void
		{
		}
		
		public function exit():void
		{
		}
	}
}