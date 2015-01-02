package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class ToxicLogic extends FirePitLogic
	{
		public function ToxicLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 2;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			if (score == 1 || score == 3 || score == 5)
			{
				Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
				isBull = true;
			}
			else
			{
				Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Cow");
				isBull = false;
			}
		}
		
	}
}