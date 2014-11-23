package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Sharks;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Island extends FirePit
	{
		public function Island()
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			Background(getObject("Background")).image.texture = Assets.getTexture("CowFall_bckg5");
			
			var animation:Sprite = getObject("Animation");
			var animIndex:int = getChildIndex(animation);
			removeObject(animation);
			
			var sharks:Sprite = new Sharks();
			sharks.x = 0;
			sharks.y = getObject("Background").height - sharks.height;
			addChildAt(sharks, animIndex);
			Sharks(sharks).play();
			sharks.name = "Animation";
			addObject(sharks);
		}
		
	}
}