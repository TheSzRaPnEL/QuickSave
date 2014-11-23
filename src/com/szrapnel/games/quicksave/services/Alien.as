package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Eggs;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Alien extends FirePit
	{
		
		public function Alien()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg7");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var eggs:Sprite = new Eggs();
			eggs.x = 0;
			eggs.y = getObject("Background").height - eggs.height;
			addChildAt(eggs, animIndex);
			Eggs(eggs).play();
			eggs.name = "Animation";
			addObject(eggs);
		}
		
	}
}