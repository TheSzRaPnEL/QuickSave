package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class WoodsLogic extends FirePitLogic
	{
		public function WoodsLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
		}
		
		protected override function onEFrame(e:Event):void
		{
			var obstacleTop:Sprite = gameStage.getObject("ObstacleTop");
			obstacleTop.x = symulation.getBody("ObstacleTop").position.x;
			obstacleTop.y = symulation.getBody("ObstacleTop").position.y;
			
			var obstacleBot:Sprite = gameStage.getObject("ObstacleBot");
			obstacleBot.x = symulation.getBody("ObstacleBot").position.x;
			obstacleBot.y = symulation.getBody("ObstacleBot").position.y;
			
			super.onEFrame(e);
		}
		
		protected override function dropNewCow():void
		{
			stop();
			
			dispatchEvent(new LevelEvent(LevelEvent.COW_SAVED));
			bullCounter = 0;
			isBull = false;
			
			score++;
			
			if (score >= 4)
			{
				Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/4";
				dispatchEvent(new LevelEvent(LevelEvent.WON));
			}
			else
			{
				Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
				isBull = true;
				Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/4";
				symulation.dropNewCow();
				start();
			}
		}
		
	}
}