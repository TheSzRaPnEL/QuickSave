package com.szrapnel.games.quicksave.services
{
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
		
	}
}