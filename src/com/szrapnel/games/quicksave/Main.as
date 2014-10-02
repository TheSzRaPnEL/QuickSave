package com.szrapnel.games.quicksave {
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	
	/**
	 * QuickSave document class
	 * @author SzRaPnEL
	 */
	public class Main extends Sprite 
	{
		private var star:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			star = new Starling(StarlingMain, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			star.stage.stageWidth  = 540;
			star.stage.stageHeight = 960;
			star.start();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
}