package com.szrapnel.games.quicksave.states.levelStates 
{
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class LoseState implements IState 
	{
		private var _name:String;
		private var actor:*;
		
		public function LoseState(actor:*) 
		{
			this.actor = actor;
			_name = "initState";
		}
		
		public function enter():void 
		{
			if (actor.gameBackground == null)
			{
				actor.gameBackground = new Quad(Starling.current.viewPort.width, Starling.current.viewPort.height, 0x1A1A1A);
				actor.gameBackground.blendMode = BlendMode.NONE;
				actor.gameBackground.touchable = false;
				actor.addChild(actor.gameBackground);
			}
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}
}