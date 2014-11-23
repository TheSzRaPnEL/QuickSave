package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import com.szrapnel.games.services.SoundController;
	import flash.media.Sound;
	
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
			actor.levelPool.getLevel(actor.currentLevel).visible = true;
			actor.levelPool.getLevel(actor.currentLevel).touchable = true;
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.init();
			if (actor.currentLevel == 6)
			{
				SoundController.playMusic(Assets.assetManager.getSound("alienmusic"));
			}
			else
			{
				SoundController.playMusic(Assets.assetManager.getSound("music"));
			}
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.addEventListener(LevelEvent.WON, levelWon_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.COW_SAVED, cowSaved_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.addEventListener(LevelEvent.COW_SAVED, cowSaved_handler);
		}
		
		private function cowSaved_handler(e:LevelEvent):void 
		{
			actor.sharedObject.data.saved++;
			
			if (actor.sharedObject.data.saved >= 1111)
			{
				actor.sharedObject.data.levels[6] = true;
			}
			
			actor.sharedObject.flush();
		}
		
		private function levelWon_handler(e:LevelEvent):void 
		{
			if (actor.levelPool.length - 1 > actor.currentLevel + 1 || (actor.levelPool.length > actor.currentLevel + 1 && actor.sharedObject.data.levels[6] == true))
			{
				actor.sharedObject.data.levels[actor.currentLevel + 1] = true;
				actor.sharedObject.flush();
				
				actor.stateMachine.setState(QuickSave.CHANGING_LEVEL);
			}
			else
			{
				actor.stateMachine.setState(QuickSave.ENTERING_MAIN_MENU_FROM_IN_GAME);
			}
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.COW_SAVED, levelWon_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.stop();
			if (actor.currentLevel == 6)
			{
				SoundController.stopMusic(Assets.assetManager.getSound("alienmusic"));
			}
			else
			{
				SoundController.stopMusic(Assets.assetManager.getSound("music"));
			}
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}
}