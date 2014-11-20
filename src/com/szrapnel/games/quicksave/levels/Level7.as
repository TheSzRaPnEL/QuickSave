package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.services.FirePitLogic;
	import com.szrapnel.games.quicksave.services.FirePitSimulation;
	import com.szrapnel.games.quicksave.services.Swamp;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level7 extends Level1
	{
		public function Level7()
		{
			super();
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new Swamp();
				gameStage.generate();
				Sprite(gameStage).clipRect = new Rectangle(0, 0, 540, 960);
				addChild(Sprite(gameStage));
				
				symulation = new FirePitSimulation();
				symulation.generate();
				
				gameLogic = new FirePitLogic(gameStage, symulation);
				addChild(Sprite(gameLogic));
				Sprite(gameLogic).touchable = false;
			}
			else
			{
				delay = 0.01;
			}
			
			TweenLite.delayedCall(delay, dispatchLevelReady);
		}
		
	}
}