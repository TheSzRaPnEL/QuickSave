package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.services.Assets;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Swamp extends FirePit
	{
		public function Swamp()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg2");
		}
		
	}
}