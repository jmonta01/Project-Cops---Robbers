package com.montydigital.gameEngine.core.states
{
	import com.montydigital.gameEngine.core.prop.IProp;

	public class PropState implements IState
	{
		
		private var prop:IProp;
		
		public function PropState(prop:IProp)
		{
			this.prop = prop;
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