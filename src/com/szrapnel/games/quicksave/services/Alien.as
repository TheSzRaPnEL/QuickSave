package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Eggs;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
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
			
			var scoreBoard:Sprite = new Sprite();
			scoreBoard.touchable = false;
			scoreBoard.visible = false;
			addChild(scoreBoard);
			scoreBoard.name = "ScoreBoard";
			addObject(scoreBoard);
			
			var topScoreLabel:TextField = new TextField(250, 80, "BEST", "font", 30, 0xffffff, true);
			topScoreLabel.touchable = false;
			topScoreLabel.autoScale = true;
			topScoreLabel.hAlign = HAlign.CENTER;
			topScoreLabel.vAlign = VAlign.CENTER;
			topScoreLabel.x = 145;
			topScoreLabel.y = 80;
			scoreBoard.addChild(topScoreLabel)
			topScoreLabel.name = "TopScoreLabel";
			
			var topScore:TextField = new TextField(250, 90, "0", "font", 70, 0xff7300);
			topScore.touchable = false;
			topScore.autoScale = true;
			topScore.hAlign = HAlign.CENTER;
			topScore.vAlign = VAlign.CENTER;
			topScore.x = 145;
			topScore.y = 140;
			scoreBoard.addChild(topScore)
			topScore.name = "TopScore";
			
			var scoreLabel:TextField = new TextField(250, 80, "YOUR SCORE", "font", 60, 0xffffff, true);
			scoreLabel.touchable = false;
			scoreLabel.autoScale = true;
			scoreLabel.hAlign = HAlign.CENTER;
			scoreLabel.vAlign = VAlign.CENTER;
			scoreLabel.x = 145;
			scoreLabel.y = 230;
			scoreBoard.addChild(scoreLabel)
			scoreLabel.name = "ScoreLabel";
			
			var score:TextField = new TextField(250, 90, "0", "font", 70, 0xff7300);
			score.touchable = false;
			score.autoScale = true;
			score.hAlign = HAlign.CENTER;
			score.vAlign = VAlign.CENTER;
			score.x = 145;
			score.y = 290;
			scoreBoard.addChild(score)
			score.name = "Score";
		}
		
	}
}