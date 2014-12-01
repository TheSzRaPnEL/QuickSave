package com.szrapnel.games.quicksave.states.gameStates
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.services.IGameLogic;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import com.szrapnel.games.services.SoundController;
	
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
			var currentLevel:ILevel = actor.levelPool.getLevel(actor.currentLevel);
			currentLevel.visible = true;
			currentLevel.touchable = true;
			var currentLevelLogic:IGameLogic = currentLevel.gameLogic;
			currentLevelLogic.init();
			currentLevel.gameStage.getObject("Animation").play();
			
			SoundController.playMusic(Assets.assetManager.getSound(currentLevel.musicName));
			
			currentLevelLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			currentLevelLogic.addEventListener(LevelEvent.WON, levelWon_handler);
			currentLevelLogic.removeEventListener(LevelEvent.COW_SAVED, cowSaved_handler);
			currentLevelLogic.addEventListener(LevelEvent.COW_SAVED, cowSaved_handler);
			currentLevel.gameStage.removeEventListener(LevelEvent.BACK_BTN_PRESSED, onBackBtnPressed_handler);
			currentLevel.gameStage.addEventListener(LevelEvent.BACK_BTN_PRESSED, onBackBtnPressed_handler);
		}
		
		private function onBackBtnPressed_handler(e:LevelEvent):void 
		{
			actor.stateMachine.setState(QuickSave.ENTERING_MAIN_MENU_FROM_IN_GAME);
		}
		
		private function cowSaved_handler(e:LevelEvent):void
		{
			actor.sharedObject.data.saved += 22;
			
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
			var currentLevel:ILevel = actor.levelPool.getLevel(actor.currentLevel);
			currentLevel.gameLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			currentLevel.gameLogic.removeEventListener(LevelEvent.COW_SAVED, levelWon_handler);
			currentLevel.gameStage.removeEventListener(LevelEvent.BACK_BTN_PRESSED, onBackBtnPressed_handler);
			currentLevel.gameLogic.stop();
			currentLevel.gameStage.getObject("Animation").stop();
			
			SoundController.stopMusic(Assets.assetManager.getSound(currentLevel.musicName));
		}
		
		public function get name():String
		{
			return _name;
		}
		
	}
}