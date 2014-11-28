package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class RocketSiloLogic extends FirePitLogic
	{
		public function RocketSiloLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 4;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			if (score == 1 || score == 3)
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