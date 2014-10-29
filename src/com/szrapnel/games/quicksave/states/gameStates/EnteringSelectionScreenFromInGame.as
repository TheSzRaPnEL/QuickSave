package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class EnteringSelectionScreenFromInGame implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		
		public function EnteringSelectionScreenFromInGame(actor:*)
		{
			this.actor = actor;
			_name = "enteringSelectionScreenFromInGameState";
		}
		
		public function enter():void
		{
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.theend();
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.touchable = false;
			
			actor.selectionScreen.visible = true;
			actor.selectionScreen.alpha = 0;
			actor.selectionScreen.touchable = false;
			
			tween = new TweenLite(actor.selectionScreen, 0.3, {x: actor.offset, y: 0, alpha: 1, scaleX: 1, scaleY: 1, onComplete: enterComplete_handler});
			tween.play();
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			dispatchShowAdmobRequest();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.SELECTION_SCREEN);
		}
		
		private function dispatchShowAdmobRequest():void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_ADMOB));
		}
		
	}
}