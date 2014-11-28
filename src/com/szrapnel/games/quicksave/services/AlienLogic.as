package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.services.Assets;
	import flash.net.SharedObject;
	import starling.display.Sprite;
	import starling.text.TextField;
	
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
			super.endGame();
			
			var sharedObject:SharedObject = SharedObject.getLocal("CowFallSO", "/");
			if (sharedObject.data.bestScore == null)
			{
				sharedObject.data.bestScore = 0;
			}
			if (sharedObject.data.bestScore < score)
			{
				sharedObject.data.bestScore = score;
				sharedObject.flush();
			}
			
			var scoreBoard:Sprite = gameStage.getObject("ScoreBoard");
			TextField(scoreBoard.getChildByName("TopScore")).text = String(sharedObject.data.bestScore);
			TextField(scoreBoard.getChildByName("Score")).text = String(score);
			scoreBoard.visible = true;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			if (score != 0 && score % 10 == 0)
			{
				gameStage.getObject("Cow").image.texture = Assets.getTexture("CowFall_Bull");
				isBull = true;
			}
			else
			{
				gameStage.getObject("Cow").image.texture = Assets.getTexture("CowFall_Cow");
				isBull = false;
			}
		}
		
		public override function stop():void
		{
			super.stop();
			
			gameStage.getObject("ScoreBoard").visible = false;
		}
		
	}
}