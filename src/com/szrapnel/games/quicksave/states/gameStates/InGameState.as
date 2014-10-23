package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.quicksave.states.IState;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class InGameState implements IState 
	{
		private var _name:String;
		private var actor:*;
		
		public function InGameState(actor:*) 
		{
			this.actor = actor;
			_name = "inGameState";
		}
		
		public function enter():void 
		{
			actor.gameStage.touchable = true;
			actor.gameLogic.theend();
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