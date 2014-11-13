package com.szrapnel.games.quicksave.states.levelStates 
{
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class PlayingState implements IState 
	{
		private var _name:String;
		private var actor:*;
		
		public function PlayingState(actor:*) 
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