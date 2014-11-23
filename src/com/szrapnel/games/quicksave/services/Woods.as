package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Saw;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Woods extends FirePit
	{
		public function Woods()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg6");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var saw:Sprite = new Saw();
			saw.x = 0;
			saw.y = getObject("Background").height - saw.height;
			addChildAt(saw, animIndex);
			Saw(saw).play();
			saw.name = "Animation";
			addObject(saw);
		}
		
	}
}