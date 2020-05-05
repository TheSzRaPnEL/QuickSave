package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.services.RocketSilo;
	import com.szrapnel.games.quicksave.services.RocketSiloLogic;
	import com.szrapnel.games.quicksave.services.RocketSiloSimulation;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level3 extends ALevel
	{
		public function Level3()
		{
			super();
			
			musicName = "music";
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new RocketSilo();
				gameStage.generate();
				var quad:Quad = new Quad(540, 960);
				quad.x = 0;
				quad.y = 0;
				Sprite(gameStage).mask = quad;
				addChild(Sprite(gameStage));
				
				symulation = new RocketSiloSimulation();
				symulation.generate();
				
				gameLogic = new RocketSiloLogic(gameStage, symulation);
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