package com.szrapnel.games.quicksave 
{
	import nape.geom.Vec2;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class GameLogic extends Sprite
	{
		private var gameStage:GameStage;
		private var symulation:Symulation;
		private var startTime:Number;
		private var score:int;
		private var level:int;
		private var now:Number;
		
		public function GameLogic(gameStage:GameStage,symulation:Symulation) 
		{
			this.gameStage = gameStage;
			this.symulation = symulation;
			
			gameStage.playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
		}
		
		private function onPlayBtnTouch(e:TouchEvent):void 
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					gameStage.playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
					gameStage.playBtn.alpha = 0;
					gameStage.playBtn.touchable = false;
					
					init();
				}
			}
		}
		
		public function init():void
		{
			startTime = new Date().time;
			score = 0;
			level = 1;
			gameStage.banner.savedTxtf.text = "" + score+"/" + (level * 10);
			addEventListener(Event.ENTER_FRAME, onEFrame);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					if (symulation.platform.velocity.x > -500)
					{
						symulation.platform.velocity.x = -500;
					}
					else
					{
						symulation.platform.velocity.x -= 100;
					}
				}
			}
		}
		
		private function onEFrame(e:Event):void 
		{
			gameStage.cow.x = symulation.ball.position.x;
			gameStage.cow.y = symulation.ball.position.y;
			gameStage.cow.rotation = symulation.ball.rotation;
			
			gameStage.platform.x = symulation.platform.position.x;
			
			if (gameStage.cow.y > 960)
			{
				theend();
			}
			else if (gameStage.cow.x > 540 || gameStage.cow.x < -110)
			{
				dropNewCow();
			}
			else
			{
				now = new Date().time;
				symulation.update((now - startTime - 1) / 1000);
				startTime = now;
			}
		}
		
		private function dropNewCow():void 
		{
			score++;
			if (score >= level*10)
			{
				level++;
				symulation.space.gravity = Vec2.weak(0, 500+100*level);
			}
			gameStage.banner.savedTxtf.text = "" + score+"/" + (level * 10);
			symulation.dropNewCow();
		}
		
		private function theend():void 
		{
			symulation.reset();
			symulation.update(0);
			
			gameStage.cow.x = symulation.ball.position.x;
			gameStage.cow.y = symulation.ball.position.y;
			gameStage.platform.x = symulation.platform.position.x;
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			removeEventListener(TouchEvent.TOUCH, onTouch);
			
			gameStage.playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			gameStage.playBtn.alpha = 1;
			gameStage.playBtn.touchable = true;
		}
		
	}

}