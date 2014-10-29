package com.szrapnel.games.quicksave.states.gameStates 
{
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
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			SoundController.stopMusic(Assets.assetManager.getSound("music"));
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}
}