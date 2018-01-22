package states
{
	import com.greensock.TweenMax;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import objects.BackgroundHills;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Credits extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundHills
		private var menubtn:Button;
		private var slateCredits:Image;
		
		public function Credits(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundHills();
			background.hills1.x = Game.xCordHill1;
			background.hills2.x = Game.xCordHill2;
			addChild(background)
			
			menubtn = new Button(Assets.ta.getTexture("btnMenu_Up"));
			menubtn.pivotX = menubtn.width * 0.5;
			menubtn.pivotY = menubtn.height * 0.5;
			menubtn.y = 590;
			menubtn.x = 475;
			TweenMax.to(menubtn, 1, {y:490});
			menubtn.scaleX = 0.2;
			menubtn.scaleY = 0.2;
			menubtn.addEventListener(Event.TRIGGERED, onMenu);
			addChild(menubtn);
			
			slateCredits = new Image(Assets.slateCreditsTexture);
			slateCredits.pivotX = slateCredits.width * 0.5;
			slateCredits.pivotY = slateCredits.height * 0.5;
			slateCredits.y = -500;
			slateCredits.x = 475;
			TweenMax.to(slateCredits, 1, {y:250});
			addChild(slateCredits);
		}
		
		private function onMenu():void
		{
			Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
			TweenMax.to(menubtn, 0.2, {y:591, onComplete: destroyAll});
			TweenMax.to(slateCredits, 0.2, {y:-500});
		}
		
		private function destroyAll():void
		{
			game.changeState(Game.MENU_STATE);
		}
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
			background.removeFromParent(true);
			background = null;
			
			menubtn.removeFromParent(true);
			menubtn = null;
			
			slateCredits.removeFromParent(true);
			slateCredits = null;
			
			removeFromParent(true);
		}
	}
}