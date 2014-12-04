package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.enum.PlatformHideDirection;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.Platform;
	import com.szrapnel.games.services.Assets;
	import flash.net.SharedObject;
	import nape.geom.Vec2;
	import nape.phys.Body;
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
			
			var platformObject:* = gameStage.getObject("Platform");
			var hand:* = gameStage.getObject("Hand");
			var platform:Body = symulation.getBody("Platform");
			var platformInner:Body = symulation.getBody("PlatformInner");
			platform.velocity = Vec2.weak();
			platformInner.velocity = Vec2.weak();
			
			if (score != 0 && platform.userData.hideDirection == PlatformHideDirection.RIGHT)
			{
				hand.x = -80;
				platform.position.x = -150;
				platformInner.position.x = -150;
				platformObject.image.x = 170;
				platformObject.image.width = -180;
				platform.userData.hideDirection = PlatformHideDirection.LEFT;
			}
			else
			{
				hand.x = 630;
				platform.position.x = 520;
				platformInner.position.x = 520;
				platformObject.image.x = 0;
				platformObject.image.width = 180;
				platform.userData.hideDirection = PlatformHideDirection.RIGHT;
			}
		}
		
		public override function stop():void
		{
			super.stop();
			
			gameStage.getObject("ScoreBoard").visible = false;
		}
		
	}
}