package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.items.Banner;
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
				if (score == 3)
				{
					Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Bull");
					isBull = true;
				}
				else
				{
					Cow(gameStage.getObject("Cow")).image.texture = Assets.getTexture("CowFall_Cow");
				}
				
				Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/4";
				symulation.dropNewCow();
				start();
			}
		}
		
	}
}