package states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Power0;
	import com.greensock.plugins.OnCompleteRenderPlugin;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import interfaces.IState;
	
	import managers.MusicManager;
	
	import objects.BackgroundCastle;
	import objects.HealthBars;
	import objects.Hero;
	import objects.SlimeBall;
	import objects.SlimeBoss;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Battle extends Sprite implements IState
	{
		private static var HERO:String = "hero";
		private static var SLIME_BOSS:String = "slime boss";
		
		private var game:Game;
		private var background:BackgroundCastle;
		private var hero:Hero;
		private var slimeboss:SlimeBoss;
		
		private var walk:String = "walk";
		private var idle:String = "idle";
		private var jab:String = "jab";
		private var swipe:String = "swipe";
		private var move:String = "move";
		private var attack:String = "attack";
		private var shoot:String = "shoot";
		
		private var openingCall:DelayedCall;
		private var heroTurnDelay:DelayedCall;
		private var bossTurnDelay2:DelayedCall;
		private var buttonDropDelay:DelayedCall;
		private var intiateFight:DelayedCall;
		private var heroTurnEnd:DelayedCall;
		
		private var healthBars:HealthBars;
		private var btnforfeit:Button;
		private var txtGuide:TextField;
		private var firstClick:Boolean = true;
		private var fightTime:int = 300;
		private var hitCount:int;
		private var slimeBall:SlimeBall;
		
		
		public function Battle(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			MusicManager.playMusicFortress(true);
			
			background = new BackgroundCastle();
			addChild(background);
			
			slimeBall = new SlimeBall(this);
			addChild(slimeBall);
			
			hero = new Hero(this);
			hero.x = -50;
			hero.y = 475;
			hero.heroWalk.fps = 5;
			addChild(hero);
			
			slimeboss = new SlimeBoss(this);
			slimeboss.x = 1050;
			slimeboss.y = 475;
			addChild(slimeboss);
			
			btnforfeit = new Button(Assets.ta.getTexture("btnForfeit_Up"),"", Assets.ta.getTexture("btnForfeit_Down"));
			btnforfeit.pivotX = btnforfeit.width * 0.5;
			btnforfeit.pivotY = btnforfeit.height * 0.5;
			btnforfeit.x = 475;
			btnforfeit.y = -100;
			btnforfeit.scaleX = 0.35;
			btnforfeit.scaleY = 0.35;
			btnforfeit.addEventListener(Event.TRIGGERED, onForfeit);
			addChild(btnforfeit);
			
			txtGuide = new TextField(400, 200, "", Game.FONT_VCR,20, 0xf0f8ff, false);
			txtGuide.pivotX = txtGuide.width * 0.5;
			txtGuide.pivotY = txtGuide.height * 0.5;
			txtGuide.x = 475;
			txtGuide.y = 200;
			txtGuide.visible = false;
			addChild(txtGuide);
			
			openingCall = new DelayedCall(openSequence,3);
			Starling.juggler.add(openingCall);
			
			healthBars = new HealthBars(this);
			addChild(healthBars);

		}
		
		private function openSequence():void
		{
			buttonDropDelay = new DelayedCall(dropUI,3);
			hero.anim(walk,true, -1);
			slimeboss.anim(move, true);
			TweenMax.to(slimeboss, 3, {x:800, onComplete: slimeboss.anim, onCompleteParams:[idle, true,], ease: Power0.easeNone});
			TweenMax.to(hero, 3, {x:150, onComplete: hero.anim, onCompleteParams:[idle, true, -1], ease: Power0.easeNone});
			
			Starling.juggler.add(buttonDropDelay);
		}
			
		private function dropUI():void
		{
			intiateFight = new DelayedCall(startFight,3);
			TweenMax.to(healthBars.heroHealthBar, 2, {y:50});
			TweenMax.to(healthBars.bossHealthBar, 2, {y:50});
			TweenMax.to(btnforfeit, 2, {y:40});
			
			Starling.juggler.add(intiateFight);
		}
		
		private function startFight():void
		{
			txtGuide.visible  = true;
			txtGuide.text = "Attack the Slime Boss!";
			TweenMax.to(txtGuide, 2, {scaleX: 1.5, scaleY: 1.5});
			slimeboss.addEventListener(TouchEvent.TOUCH, onSlimeTouch);
			
			heroTurnEnd = new DelayedCall(endHeroTurn,3.5);
			Starling.juggler.add(heroTurnEnd);
			
		}
		
		private function onSlimeTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			
			if(touch)
			{
				if( firstClick && touch.phase == TouchPhase.ENDED)
				{
					trace("First touch");
					firstClick = false;
					hero.anim(jab, true, 0);
					TweenMax.to(hero, 0.1, {x:650, ease: Power0.easeNone});
					addChild(hero);
				} 
				else if (firstClick == false && touch.phase == TouchPhase.ENDED)
				{
					trace("o");
					hero.swipe();
					Assets.sfxHit1.play(0,1, new SoundTransform(0.05));
					hitCount++;
					trace(hitCount);
				} 
				else
				{
					trace("Not touched");
				}
			}
		}
		
		private function hitCalculator():void
		{
			if(hero.health <= 0)
			{
				onForfeit()
				/*
				TweenMax.allTo([hero,slimeboss,background,txtGuide,btnforfeit,healthBars,slimeBall,slimeboss.slimeIdle,slimeboss.slimeAttack], 0.3, {y:700, onComplete: destroyall, onCompleteParams:["hero"]});
				destroyall("hero"); */
				/*
				game.changeState(Game.END_STATE);
				Game.gameOutcome = "hero";
				MusicManager.playMusicFortress(false);*/
			}
			if(hitCount == 10)
			{
				healthBars.reduceHealthBar(SLIME_BOSS, 1);
				slimeboss.health -= 10;
				hitCount = 0;
				trace(slimeboss.health);
			}
		}
		
		private function bosssAttackCalculator():void
		{
			var num:int = Math.ceil(Math.random()*15);
			var num2:int = Math.ceil(Math.random()*5);
			var finalNum:int;
			
			if(num2 == 1)
			{
				finalNum = num + 5;
			}
			else
			{
				finalNum = num;
			}
			
			if(finalNum >= 7)
			{
				if(finalNum >= 13)
				{
					if(finalNum >= 20)
					{
						if(healthBars.heroHealthBar.currentFrame + 4 <= 10)
						{
							healthBars.reduceHealthBar(HERO, 4);
							hero.health -=40;
							trace("Hero Health at: " + hero.health);
						}
						else
						{
							healthBars.heroHealthBar.currentFrame = 10;
							hero.health -=40;
							trace("Hero Health at: " + hero.health);
						}
					}
					else
					{
						if(healthBars.heroHealthBar.currentFrame + 3 <= 10)
						{
							healthBars.reduceHealthBar(HERO, 3);
							hero.health -=30;
							trace("Hero Health at: " + hero.health);
						}
						else
						{
							healthBars.heroHealthBar.currentFrame = 10;
							hero.health -=30;
							trace("Hero Health at: " + hero.health);
						}
					}
					
				}
				else
				{
					if(healthBars.heroHealthBar.currentFrame + 2 <= 10)
					{
						healthBars.reduceHealthBar(HERO, 2);
						hero.health -=20;
						trace("Hero Health at: " + hero.health);
					}
					else
					{
						healthBars.heroHealthBar.currentFrame = 10;
						hero.health -=20;
						trace("Hero Health at: " + hero.health);
					}
				}
			} 
			else
			{
				healthBars.reduceHealthBar(HERO, 1);
				hero.health -=10;
				trace("Hero Health at: " + hero.health);
			}
			
		}
		
		private function endHeroTurn():void
		{
			bossTurnDelay2 = new DelayedCall(bossturn,2);
			firstClick = true;	
			
			slimeboss.removeEventListener(TouchEvent.TOUCH, onSlimeTouch);
			hitCount = 0;
			
			trace("hero turn ended");
			trace(slimeboss.health);
			trace(slimeboss.reverseHealth);
			txtGuide.visible = false;
			hero.removeChildren();
			
			TweenMax.to(hero, 0.1, {x:150, onComplete: hero.anim, onCompleteParams:[idle, true, -1], ease: Power0.easeNone})
			
			Starling.juggler.add(bossTurnDelay2);
		}
		
		private function bossturn():void
		{
			txtGuide.text = "Slime boss is attacking";
			txtGuide.visible = true;
			TweenMax.to(txtGuide, 3, {scaleX: 1.5, scaleY: 1.5});
			
			addChild(slimeBall);
			addChild(slimeboss);
			slimeboss.shootSlime();
			slimeBall.anim(shoot,true);
			slimeBall.x = slimeboss.x;
			slimeBall.y = slimeboss.y - 30;
			slimeBall.scaleX = 0.8;
			slimeBall.scaleY = 0.85;
			slimeBall.rotation = 0;
			TweenMax.to(slimeBall, 3.5, {y:-50, ease: Power0.easeNone, onComplete: slimeDown});
			
		}
		
		private function slimeDown():void
		{
			addChild(slimeBall);
			slimeBall.rotation = 3;
			slimeBall.x = hero.x;
			slimeBall.y = -50;
			TweenMax.to(slimeBall, 2, {y:hero.y - 120, ease: Power0.easeNone, onComplete: bossTurnEnd})
		}
		
		private function bossTurnEnd():void
		{
			heroTurnDelay = new DelayedCall(startFight,2);
			
			removeChild(slimeBall);
			Assets.sfxHit1.play(0,1, new SoundTransform(0.05));
			
			bosssAttackCalculator();
			trace("Boss turn ended");
			txtGuide.visible = false;
			
			Starling.juggler.add(heroTurnDelay);
		}
		
		public function update():void
		{
			hero.update();
			slimeboss.update();
			hitCalculator();
			
			if(hero.health <= 0)
			{
				
				TweenMax.allTo([hero,slimeboss,background,txtGuide,btnforfeit,healthBars,slimeBall,slimeboss.slimeIdle,slimeboss.slimeAttack], 0.3, 
					{y:700/*, onComplete: destroyall, onCompleteParams:["hero"]*/});

				
				Game.gameOutcome = "hero";
				game.changeState(Game.END_STATE);
				MusicManager.playMusicFortress(false);
			}
			else if(slimeboss.health <= 0)
			{
				TweenMax.allTo([hero,slimeboss,background,txtGuide,btnforfeit,healthBars,slimeBall,], 0.3, {y:700/*, onComplete: destroyall, onCompleteParams:["boss"]*/});
				
				Game.gameOutcome = "boss";
				game.changeState(Game.END_STATE);
				MusicManager.playMusicFortress(false);
			}
		}
		
		private function onForfeit():void
		{
			Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
			TweenMax.allTo([hero,slimeboss,background,txtGuide,btnforfeit,healthBars,slimeBall], 0.3, {y:700, onComplete: destroyall, onCompleteParams:["hero"]});
		}
		
		private function destroyall(character:String):void
		{
			trace("got this far");
			Game.gameOutcome = character;
			game.changeState(Game.END_STATE);
			MusicManager.playMusicFortress(false);
		}
		
		public function destroy():void
		{
			MusicManager.playMusicFortress(false);
			
			background.removeFromParent(true);
			background = null;
			
			hero.removeFromParent(true);
			hero = null;
			
			slimeboss.removeFromParent(true);
			slimeboss = null;
			
			healthBars.removeFromParent(true);
			healthBars = null;
			
			btnforfeit.removeFromParent(true);
			btnforfeit = null;
			
			txtGuide.removeFromParent(true);
			txtGuide = null;
			
			slimeBall.removeFromParent(true);
			slimeBall = null;
			
			Starling.juggler.remove(openingCall);
			Starling.juggler.remove(heroTurnDelay);
			Starling.juggler.remove(bossTurnDelay2);
			Starling.juggler.remove(buttonDropDelay);
			Starling.juggler.remove(intiateFight);
			Starling.juggler.remove(heroTurnEnd);
			
			removeFromParent(true);
		}
	}
}