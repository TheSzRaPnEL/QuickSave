package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.services.Woods;
	import com.szrapnel.games.quicksave.services.WoodsLogic;
	import com.szrapnel.games.quicksave.services.WoodsSimulation;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level6 extends ALevel
	{
		public function Level6()
		{
			super();
			
			musicName = "music";
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new Woods();
				gameStage.generate();
				var quad:Quad = new Quad(540, 960);
				quad.x = 0;
				quad.y = 0;
				Sprite(gameStage).mask = quad;
				addChild(Sprite(gameStage));
				
				symulation = new WoodsSimulation();
				symulation.generate();
				
				gameLogic = new WoodsLogic(gameStage, symulation);
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