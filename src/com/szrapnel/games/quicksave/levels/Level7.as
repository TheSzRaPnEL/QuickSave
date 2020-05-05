package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.services.Alien;
	import com.szrapnel.games.quicksave.services.AlienLogic;
	import com.szrapnel.games.quicksave.services.FirePitSimulation;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level7 extends ALevel
	{
		public function Level7()
		{
			super();
			
			musicName = "alienmusic";
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new Alien();
				gameStage.generate();
				var quad:Quad = new Quad(540, 960);
				quad.x = 0;
				quad.y = 0;
				Sprite(gameStage).mask = quad;
				addChild(Sprite(gameStage));
				
				symulation = new FirePitSimulation();
				symulation.generate();
				
				gameLogic = new AlienLogic(gameStage, symulation);
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