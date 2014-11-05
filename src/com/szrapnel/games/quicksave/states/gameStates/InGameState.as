package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
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
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.theend();
			SoundController.playMusic(Assets.assetManager.getSound("music"));
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.addEventListener(LevelEvent.WON, levelWon_handler);
		}
		
		private function levelWon_handler(e:LevelEvent):void 
		{
			actor.sharedObject.data.levels[actor.currentLevel + 1] = true;
			actor.sharedObject.flush();
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			actor.levelPool.getLevel(actor.currentLevel).gameLogic.removeEventListener(LevelEvent.WON, levelWon_handler);
			SoundController.stopMusic(Assets.assetManager.getSound("music"));
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}
}