package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	
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
			
			if (actor.sharedObject.data.saved < 1111)
			{
				actor.selectionScreen.bannerText.texture = Assets.getTexture("CowFall_SScreen_level7_baner_TXT1");
				actor.selectionScreen.bannerText.x = 42;
				actor.selectionScreen.bannerNumber.text = String(1111 - actor.sharedObject.data.saved);
				actor.selectionScreen.bannerNumber.x = 81;
				actor.selectionScreen.bannerNumber.y = 27;
			}
			else
			{
				actor.selectionScreen.bannerText.texture = Assets.getTexture("CowFall_SScreen_level7_baner_TXT2");
				actor.selectionScreen.bannerText.x = 32;
				actor.selectionScreen.bannerNumber.text = String(actor.sharedObject.data.saved);
				actor.selectionScreen.bannerNumber.x = 190;
				actor.selectionScreen.bannerNumber.y = 32;
			}
			
			var levelActiveListLength:int = actor.sharedObject.data.levels != null ? actor.sharedObject.data.levels.length : 0;
			for (var i:int = 0; i < levelActiveListLength; i++)
			{
				if (actor.sharedObject.data.levels[i])
				{
					actor.selectionScreen.activateLevel(i);
				}
				else
				{
					actor.selectionScreen.deactivateLevel(i);
				}
			}
			
			actor.selectionScreen.visible = true;
			actor.selectionScreen.alpha = 1;
			actor.selectionScreen.scaleX = 1;
			actor.selectionScreen.scaleY = 1;
			actor.selectionScreen.x = actor.offset;
			actor.selectionScreen.y = actor.y;
			
			tween = new TweenLite(actor.introMovie, 0.3, {x: actor.offset-actor.introMovie.width / 4, y: -actor.introMovie.height / 4, alpha: 0, scaleX: 1.5, scaleY: 1.5, onComplete: enterComplete_handler});
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