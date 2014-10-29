package com.szrapnel.games.quicksave.levels
{
	import com.szrapnel.games.services.Assets;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Level2 extends Level1
	{
		public function Level2() 
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			gameStage.background.image.texture = Assets.getTexture("CowFall_bckg3");
		}
		
	}
}