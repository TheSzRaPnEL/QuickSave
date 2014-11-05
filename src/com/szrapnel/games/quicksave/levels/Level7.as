package com.szrapnel.games.quicksave.levels
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.services.Assets;
	
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
			super.generate();
			
			Background(gameStage.getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg3");
		}
		
	}
}