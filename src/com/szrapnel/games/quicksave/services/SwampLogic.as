package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.services.Assets;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SwampLogic extends FirePitLogic
	{
		public function SwampLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			super(gameStage, symulation);
			
			scoreToWin = 2;
		}
		
		protected override function dropNewCow():void
		{
			super.dropNewCow();
			
			if (score == 2)
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