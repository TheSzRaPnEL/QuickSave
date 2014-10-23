package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.states.IState;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class EnteringSelectionScreenFromMainMenu implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		
		public function EnteringSelectionScreenFromMainMenu(actor:*)
		{
			this.actor = actor;
			_name = "enteringSelectionScreenFromMainMenuState";
		}
		
		public function enter():void
		{
			if (actor.selectionScreen == null)
			{
				actor.selectionScreen = new SelectionScreen();
				actor.addChildAt(actor.selectionScreen, 1);
				actor.selectionScreen.touchable = false;
			}
			
			actor.selectionScreen.visible = true;
			
			tween = new TweenLite(actor.introMovie, 0.3, {x: -actor.introMovie.width / 4, y: -actor.introMovie.height / 4, alpha: 0, scaleX: 1.5, scaleY: 1.5, onComplete: enterComplete_handler});
			tween.play();
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			removeIntroScreen();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.SELECTION_SCREEN);
		}
		
		private function removeIntroScreen():void
		{
			actor.introMovie.visible = false;
			actor.introMovie.touchable = false;
		}
	
	}
}