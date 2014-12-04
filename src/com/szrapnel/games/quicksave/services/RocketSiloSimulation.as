package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.enum.PlatformType;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class RocketSiloSimulation extends FirePitSimulation
	{
		private var obstacleLeft:Body;
		private var obstacleRight:Body;
		
		public function RocketSiloSimulation():void
		{
			super();
		}
		
		public override function generate():void
		{
			super.generate();
			
			var platform:Body = getBody("Platform");
			platform.userData.type = PlatformType.BUTTON;
		}
		
	}
}