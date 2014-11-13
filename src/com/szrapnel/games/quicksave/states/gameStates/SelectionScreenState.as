package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.events.Event;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class SelectionScreenState implements IState 
	{
		private var _name:String;
		private var actor:*;
		
		public function SelectionScreenState(actor:*) 
		{
			this.actor = actor;
			_name = "selectionScreenState";
		}
		
		public function enter():void 
		{
			actor.selectionScreen.touchable = true;
			actor.selectionScreen.removeEventListener(Event.TRIGGERED, onSelectionScreenTriggered_handler);
			actor.selectionScreen.addEventListener(Event.TRIGGERED, onSelectionScreenTriggered_handler);
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			actor.selectionScreen.touchable = false;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		private function onSelectionScreenTriggered_handler(e:Event):void 
		{
			actor.currentLevel = e.data;
			trace(actor.currentLevel);
			actor.stateMachine.setState(QuickSave.ENTERING_IN_GAME_FROM_SELECTION_SCREEN);
		}
		
	}
}