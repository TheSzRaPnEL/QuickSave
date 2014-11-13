package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.display.DisplayObject;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class EnteringMainMenuFromInGame implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		
		public function EnteringMainMenuFromInGame(actor:*)
		{
			this.actor = actor;
			_name = "enteringMainMenuFromInGame";
		}
		
		public function enter():void
		{
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.stop();
			
			actor.introMovie.visible = true;
			actor.introMovie.alpha = 0;
			actor.introMovie.touchable = false;
			
			tween = new TweenLite(actor.introMovie, 0.3, {x: actor.offset, y: 0, alpha: 1, scaleX: 1, scaleY: 1, onComplete: enterComplete_handler});
			tween.play();
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			DisplayObject(actor.levelPool.getLevel(actor.currentLevel)).removeFromParent();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.MAIN_MENU);
		}
	
	}
}