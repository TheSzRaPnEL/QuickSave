package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	import nape.geom.Vec2;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class WoodsLogic extends FirePitLogic
	{
		public function WoodsLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 4;
		}
		
		protected override function onEFrame(e:EnterFrameEvent):void
		{
			var obstacleTop:Sprite = gameStage.getObject("ObstacleTop");
			var obstacleTopBodyPos:Vec2 = symulation.getBody("ObstacleTop").position;
			obstacleTop.x = obstacleTopBodyPos.x;
			obstacleTop.y = obstacleTopBodyPos.y;
			
			var obstacleBot:Sprite = gameStage.getObject("ObstacleBot");
			var obstacleBotBodyPos:Vec2 = symulation.getBody("ObstacleBot").position;
			obstacleBot.x = obstacleBotBodyPos.x;
			obstacleBot.y = obstacleBotBodyPos.y;
			
			super.onEFrame(e);
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
			isBull = true;
		}
		
	}
}