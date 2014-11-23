package com.szrapnel.games.quicksave.states.levelStates
{
	import com.szrapnel.games.quicksave.states.IState;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class InitState implements IState
	{
		private var _name:String;
		private var actor:*;
		
		public function InitState(actor:*)
		{
			this.actor = actor;
			_name = "initState";
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
		
		public function get name():String
		{
			return _name;
		}
		
	}
}