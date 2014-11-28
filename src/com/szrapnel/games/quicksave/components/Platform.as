package com.szrapnel.games.quicksave.components 
{
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Platform 
	{
		private var _type:String;
		private var _hideDirection:String;
		
		public function Platform() 
		{
			
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get hideDirection():String 
		{
			return _hideDirection;
		}
		
		public function set hideDirection(value:String):void 
		{
			_hideDirection = value;
		}
		
	}
}