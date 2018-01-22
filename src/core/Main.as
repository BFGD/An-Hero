package core
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	
	[SWF(frameRate="60", width=950, height="534", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		
		private var myStarling:Starling;
		
		public function Main()
		{
			myStarling = new Starling(Game, stage);
			myStarling.start();
			
		}
	}
}