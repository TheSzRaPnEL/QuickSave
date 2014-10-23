package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.events.IntroEvent;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class MainMenuState implements IState 
	{
		private var _name:String;
		private var actor:*;
		
		public function MainMenuState(actor:*) 
		{
			this.actor = actor;
			_name = "mainMenuState";
		}
		
		public function enter():void 
		{
			actor.introMovie.removeEventListener(IntroEvent.START_BTN_CLICKED, onStartBtnClicked_handler);
			actor.introMovie.addEventListener(IntroEvent.START_BTN_CLICKED, onStartBtnClicked_handler);
			actor.introMovie.touchable = true;
			
			if (actor.introMovie.isPlaying)
			{
				actor.introMovie.stop();
			}
			actor.introMovie.end();
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			actor.introMovie.removeEventListener(IntroEvent.START_BTN_CLICKED, onStartBtnClicked_handler);
			actor.introMovie.touchable = false;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		private function onStartBtnClicked_handler(e:IntroEvent):void 
		{
			actor.stateMachine.setState(QuickSave.ENTERING_SELECTION_SCREEN_FROM_MAIN_MENU);
		}
		
		private function dispatchShowAdmobRequest():void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_ADMOB));
		}
		
	}
}