package com.szrapnel.games.quicksave.levels 
{
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class LevelPool 
	{
		private var levels:Vector.<ILevel>
		
		public function LevelPool() 
		{
			levels = new Vector.<ILevel>;
		}
		
		public function addLevel(level:ILevel):void
		{
			levels.push(level);
		}
		
		public function getLevel(id:int):ILevel
		{
			if (levels.length > id && levels[id] is ILevel)
			{
				return levels[id];
			}
			else
			{
				throw Error("Level with ID: " + id + " is not in the pool");
			}
		}
		
	}
}