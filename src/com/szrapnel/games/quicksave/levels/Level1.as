package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import flash.geom.Rectangle;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level1 extends ALevel
	{
		public function Level1() 
		{
			super();
		}
		
		public override function generate():void
		{
			if (!isGenerated)
			{
				delay = 0.3;
				
				gameStage = new GameStage();
				gameStage.clipRect = new Rectangle(0, 0, 540, 960);
				addChild(gameStage);
				
				symulation = new Symulation();
				
				gameLogic = new GameLogic(gameStage, symulation);
				addChild(gameLogic);
				gameLogic.touchable = false;
			}
			else
			{
				delay = 0.01;
			}
			
			TweenLite.delayedCall(delay, dispatchLevelReady);
		}
		
		public override function dispose():void
		{
			TweenLite.killDelayedCallsTo = dispatchLevelReady;
			
			if (gameLogic != null)
			{
				gameLogic.theend();
			}
		}
		
		private function dispatchLevelReady():void
		{
			isGenerated = true;
			dispatchEvent(new LevelEvent(LevelEvent.READY));
		}
		
	}
}