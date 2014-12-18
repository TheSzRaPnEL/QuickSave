package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.services.FirePitSimulation;
	import com.szrapnel.games.quicksave.services.Island;
	import com.szrapnel.games.quicksave.services.IslandLogic;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level5 extends ALevel
	{
		public function Level5()
		{
			super();
			
			musicName = "music";
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new Island();
				gameStage.generate();
				Sprite(gameStage).clipRect = new Rectangle(0, 0, 540, 960);
				addChild(Sprite(gameStage));
				
				symulation = new FirePitSimulation();
				symulation.generate();
				
				gameLogic = new IslandLogic(gameStage, symulation);
				addChild(Sprite(gameLogic));
				Sprite(gameLogic).touchable = false;
			}
			else
			{
				delay = 0.01;
			}
			
			super.generate();
			
			TweenLite.delayedCall(delay, dispatchLevelReady);
		}
		
	}
}