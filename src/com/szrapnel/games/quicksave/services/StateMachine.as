package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	
	/**
	 * Objects state handling class
	 * @author SzRaPnEL
	 */
	public class StateMachine
	{
		private var _currState:String;
		private var prevState:String;
		private var states:Object;
		
		public function StateMachine()
		{
			states = new Object();
		}
		
		public function setState(name:String):void
		{
			trace("STATE CHANGE: " + currState + " -> " + name);
			
			if (currState == null)
			{
				_currState = name;
				states[currState].state.enter();
				return;
			}
			
			if (currState == name)
			{
				return;
			}
			
			if (states[name].from.indexOf(currState) != -1)
			{
				states[currState].state.exit();
				prevState = currState;
				_currState = name;
				Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.CHANGE_GAME_STATE, false, currState));
				states[currState].state.enter();
			}
		}
		
		public function addState(name:String, stateObj:IState, fromStates:Vector.<String>):void
		{
			states[name] = {state: stateObj, from: fromStates};
		}
		
		public function get currState():String 
		{
			return _currState;
		}
		
	}
}