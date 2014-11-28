package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Banner;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class AlienLogic extends FirePitLogic
	{
		public function AlienLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
		}
		
		public override function init():void
		{
			super.init();
			
			Banner(gameStage.getObject("Banner")).savedTxtf.text = String(score);
		}
		
		protected override function addPoint():void
		{
			scoreToWin++;
			
			super.addPoint();
			
			Banner(gameStage.getObject("Banner")).savedTxtf.text = String(score);
		}
		
		public override function endGame():void
		{
			var sharedObject:SharedObject = SharedObject.getLocal("CowFallSO", "/");
			if (sharedObject.data.bestScore < score)
			{
				sharedObject.data.bestScore = score;
				sharedObject.flush();
			}
			
			super.endGame();
		}
		
	}
}