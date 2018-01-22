package objects
{
	import core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class BackgroundCastle extends Sprite
	{
		private var image:Image;
		
		public function BackgroundCastle()
		{
			image = new Image(Assets.bkgCastleTexture);
			image.pivotX = image.x * 0.5;
			image.pivotY = image.y * 0.5;
			
			addChild(image);
		}
	}
}