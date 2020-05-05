package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.items.Background;
	import com.szrapnel.games.quicksave.items.Eggs;
	import com.szrapnel.games.services.Assets;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Align;
	
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
			
			var topScoreLabelTextFormat:TextFormat = new TextFormat();
			topScoreLabelTextFormat.color = 0xffffff;
			topScoreLabelTextFormat.font = "font";
			topScoreLabelTextFormat.size = 30;
			topScoreLabelTextFormat.bold = true;
			topScoreLabelTextFormat.horizontalAlign = Align.CENTER;
			topScoreLabelTextFormat.verticalAlign = Align.CENTER;
			
			var topScoreLabel:TextField = new TextField(250, 80, "BEST", topScoreLabelTextFormat);
			topScoreLabel.touchable = false;
			topScoreLabel.autoScale = true;
			topScoreLabel.x = 145;
			topScoreLabel.y = 80;
			scoreBoard.addChild(topScoreLabel)
			topScoreLabel.name = "TopScoreLabel";
			
			var topScoreTextFormat:TextFormat = new TextFormat();
			topScoreTextFormat.color = 0xff7300;
			topScoreTextFormat.font = "font";
			topScoreTextFormat.size = 70;
			topScoreTextFormat.bold = false;
			topScoreTextFormat.horizontalAlign = Align.CENTER;
			topScoreTextFormat.verticalAlign = Align.CENTER;
			
			var topScore:TextField = new TextField(250, 90, "0", topScoreTextFormat);
			topScore.touchable = false;
			topScore.autoScale = true;
			topScore.x = 145;
			topScore.y = 140;
			scoreBoard.addChild(topScore)
			topScore.name = "TopScore";
			
			var scoreLabelTextFormat:TextFormat = new TextFormat();
			scoreLabelTextFormat.color = 0xffffff;
			scoreLabelTextFormat.font = "font";
			scoreLabelTextFormat.size = 60;
			scoreLabelTextFormat.bold = true;
			scoreLabelTextFormat.horizontalAlign = Align.CENTER;
			scoreLabelTextFormat.verticalAlign = Align.CENTER;
			
			var scoreLabel:TextField = new TextField(250, 80, "YOUR SCORE", scoreLabelTextFormat);
			scoreLabel.touchable = false;
			scoreLabel.autoScale = true;
			scoreLabel.x = 145;
			scoreLabel.y = 230;
			scoreBoard.addChild(scoreLabel)
			scoreLabel.name = "ScoreLabel";
			
			var score:TextField = new TextField(250, 90, "0", topScoreTextFormat);
			score.touchable = false;
			score.autoScale = true;
			score.x = 145;
			score.y = 290;
			scoreBoard.addChild(score)
			score.name = "Score";
		}
		
	}
}