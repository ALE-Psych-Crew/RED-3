import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.addons.effects.FlxTrail;

import funkin.visuals.FXCamera;

final splitCamera:FXCamera = new FXCamera(FlxG.width / 2, 0, FlxG.width / 2);
splitCamera.exists = false;

var subtitle:FlxText = add(new FlxText(0, FlxG.height * 0.7, FlxG.width));
subtitle.setFormat(Paths.font('vcr.ttf'), 100, FlxColor.PINK, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.fromRGB(200, 0, 0));
subtitle.borderSize = 5;

function setSubtitle(?str:String)
    if (str == null)
        subtitle.text = '';
    else
        subtitle.text += str;

var dadTrail:FlxTrail;

cacheCharacter('bfScared');

function postCreate()
{
    dad.config.bopAnimations = ['idle', null, null, null];

    addBehindDad(dadTrail = new FlxTrail(dad, null, 5, 10));

    camGame.fade(FlxColor.BLACK, 0);
    camGame.angleSpeed = 4;
    camGame.zoomSpeed = 4;

    splitCamera.setShaders([shader]);

    FlxG.cameras.insert(splitCamera, 1, true);

    camHUD.alpha = 0;

    opponentStrumLines.members[0].alpha = 0.5;

    subtitle.camera = camOther;
}

function postSongStart()
{
    final introTime:Float = startTime <= 0 ? Conductor.secCrochet * 128 : 0.01;

    camGame.fade(FlxColor.BLACK, introTime, true, null, true);

    camGame.position.set(300, 500);
    camGame.snapToTarget();

    camGame.zoom = camGame.targetZoom = 2;
    camGame.tweenZoom(0.4, introTime);

    allowCameraMoving = false;
}

var updateFunc:Float -> Void;

var curTime:Float = 0;

function onSafeBeatHit(curBeat:Int)
{
    switch (curBeat)
    {
        case 128:
            FlxTween.tween(camHUD, {alpha: 1}, Conductor.secCrochet, {ease: FlxEase.cubeOut});

            allowCameraMoving = true;

        case 192:
            camGame.targetZoom = 0.5;

        case 194:
            camGame.targetZoom = 0.6;
        
        case 196:
            camGame.targetZoom = 0.4;

        case 198:
            camGame.targetZoom = 0.5;

        case 200:
            camGame.tweenZoom(0.35, Conductor.secCrochet * 8);

        case 208:
            camGame.tweenZoom(0.5, Conductor.secCrochet * 16);
        
        case 240:
            camGame.tweenZoom(1, Conductor.secCrochet * 8);

        case 248:
            camGame.cancelZoomTween();
            camGame.targetZoom = 0.6;

        case 252:
            camGame.tweenZoom(0.3, Conductor.secCrochet * 4, {ease: FlxEase.elasticIn});

        case 256:
            camGame.targetAngle = 5;

            camGame.zoom = camGame.targetZoom = 0.3;

            camGame.tweenZoom(0.5, Conductor.secCrochet * 64);

            camHUD.targetZoom = 0.8;
            
            FlxTween.cancelTweensOf(camHUD);
            FlxTween.tween(camHUD, {alpha: 0.5}, Conductor.secCrochet);
            
            for (obj in uiGroup)
                FlxTween.tween(obj, {alpha: 0}, Conductor.secCrochet);

            epicBars(75, Conductor.secCrochet * 4);

            FlxTween.tween(dadStrumLine, {speed: 1}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});
        
        case 272:
            FlxTween.tween(dadStrumLine, {speed: 2}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

        case 288:
            FlxTween.tween(dadStrumLine, {speed: 3}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

        case 304:
            FlxTween.cancelTweensOf(dadStrumLine);
            FlxTween.tween(dadStrumLine, {speed: 20}, Conductor.secCrochet * 16);

            camHUD.targetZoom = 0.6;

        case 320:
            camHUD.targetZoom = 0.8;

            camGame.cancelZoomTween();
            camGame.targetZoom = 0.8;

        case 336:
            camGame.targetZoom = 0.9;

        case 352:
            camGame.targetZoom = 1;
        
        case 368:
            camGame.tweenZoom(0.4, Conductor.secCrochet * 16);

        case 384:
            epicBars(100);

            FlxTween.cancelTweensOf(camHUD);
            FlxTween.tween(camHUD, {alpha: 1}, Conductor.secCrochet);

            camHUD.targetZoom = 0.75;

            camGame.cancelZoomTween();
            camGame.targetAngle = 0;
            camGame.targetZoom = 0.9;

            updateFunc = elapsed -> {
                camGame.position.x = Math.cos(curTime * 4) * 25 + 900;
                camGame.position.y = Math.sin(curTime * 4) * 50 + 620;

                camGame.targetAngle = Math.sin(curTime) * 5;
            };

            changeCharacter(bf, 'bfScared');

            moveCamera(bf);

            allowCameraMoving = false;

        case 416:
            camGame.targetZoom = 0.7;

        case 428:
            camGame.targetZoom = 0.8;

        case 432:
            camGame.targetZoom = 0.5;

        case 448:
            changeCharacter(bf, 'bfAir');

            camGame.targetZoom = 0.3;

            updateFunc = elapsed -> {
                camGame.position.x = Math.cos(curTime * 4) * 50 + 100;
                camGame.position.y = Math.sin(curTime * 4) * 100 + 400;

                camGame.targetAngle = Math.sin(curTime) * 5;
            };

            FlxTween.cancelTweensOf(dadStrumLine);
            dadStrumLine.speed = chart.speed;

        case 510:
            epicBars(FlxG.height / 2, null);

        case 512:
            epicBars(0);
            
            allowCameraMoving = true;

            updateFunc = null;

            for (obj in uiGroup)
            {
                FlxTween.cancelTweensOf(obj);

                obj.alpha = 1;
            }
            
            camHUD.reset();
            camGame.reset();

            camGame.speed = 2;
            camGame.zoomSpeed = 4;

            camGame.zoom = camGame.targetZoom = 0.4;

        case 576:
            camGame.targetZoom = 0.5;

        case 580:
            camGame.targetZoom = 0.4;

        case 584:
            camGame.targetZoom = 0.3;

        case 586:
            camGame.targetZoom = 0.2;

        case 588:
            camGame.targetZoom = 0.4;

        case 592:
            camGame.targetZoom = 0.7;

        case 594:
            camGame.targetZoom = 0.4;

        case 596:
            camGame.tweenZoom(0.6, Conductor.secCrochet * 4);

        case 600:
            camGame.cancelZoomTween();
            camGame.targetZoom = 0.4;
    
        case 608:
            camGame.targetZoom = 0.8;

        case 624:
            camGame.targetZoom = 0.6;

        case 632:
            camGame.targetZoom = 0.5;

        case 640:
            epicBars(FlxG.height, Conductor.secCrochet * 8, FlxEase.cubeIn);

            camHUD.targetZoom = 0.8;
            camGame.targetAngle = 180;

        case 648:
            epicBars(75, Conductor.secCrochet * 2);

            camGame.targetAngle = 0;
            camGame.targetZoom = 0.3;
            camGame.angle = -90;

            speed = 2;

        case 712:
            camGame.angle = 0;

            camGame.targetZoom = 0.4;

        case 776:
            camGame.targetZoom = 0.3;

        case 792:
            camGame.tweenZoom(0.5, Conductor.secCrochet * 8);

        case 800:
            camGame.cancelZoomTween();
            camGame.targetZoom = 0.6;

        case 804:
            camGame.targetZoom = 0.5;

        case 808:
            camGame.targetZoom = 0.9;

        case 824:
            camGame.targetZoom = 0.8;

        case 832:
            camGame.targetZoom = 0.7;

        case 836:
            camGame.targetZoom = 0.6;

        case 840:
            camGame.targetZoom = 0.4;

        case 842:
            camGame.targetZoom = 0.45;

        case 844:
            camGame.targetZoom = 0.35;

        case 846:
            camGame.targetZoom = 0.4;

        case 848:
            camGame.targetZoom = 0.45;

        case 856:
            camGame.tweenZoom(0.3, Conductor.secCrochet * 8);

        case 864:
            camGame.cancelZoomTween();
            camGame.targetZoom = 0.4;

        case 868:
            camGame.targetZoom = 0.5;

        case 872:
            camGame.targetZoom = 0.9;

        case 888:
            camGame.targetZoom = 0.8;

        case 904:
            epicBars(0);

            allowCameraMoving = false;

            camGame.position.set(-350, 550);
            camGame.targetZoom = 0.5;
            camGame.zoomSpeed = 0.5;

            FlxTween.tween(camHUD, {alpha: 0}, Conductor.secCrochet * 6);

        case 905:
            setSubtitle('OH');

        case 906:
            setSubtitle(' MY');
        
        case 908:
            setSubtitle(' GOD');

        case 910:
            subtitle.text = 'you';

        case 911:
            subtitle.text = 'you BAS';

        case 912:
            epicBars(FlxG.height / 2, Conductor.secCrochet * 6, FlxEase.elasticIn);

            camHUD.targetZoom = 1;

        case 914:
            setSubtitle('TARD');

        case 916:
            setSubtitle(', Mol');

        case 917:
            setSubtitle('dy');

        case 919:
            subtitle.text = '>:c';

        case 920:
            subtitle.text = 'AAAEAEAEAE';

            dadStrumLine.alpha = 0.25;

            FlxTween.cancelTweensOf(camHUD);

            camHUD.alpha = 1;
            
            FlxTween.tween(subtitle, {x: FlxG.width / 4, angle: 45}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});
            FlxTween.tween(subtitle, {y: FlxG.height, alpha: 0}, Conductor.secCrochet * 4, {ease: FlxEase.cubeIn});
            
            epicBars(0, Conductor.secCrochet, FlxEase.elasticOut);

            changeCharacter(bf, 'bfScared');

            shader.setFloat('bloom', 2);
            shader.tween({bloom: 1}, Conductor.secCrochet * 16);

            speed = 5;

            dadStrumLine.speed = 2;

            allowCameraMoving = false;

            splitCamera.exists = true;

            updateFunc = elapsed -> {
                camGame.position.x = Math.sin(curTime * 6) * 200 + 75;
                camGame.position.y = Math.cos(curTime * 8) * 100 + 500;

                camGame.angle = Math.sin(curTime * 2) * 2.5;


                splitCamera.position.x = Math.sin(curTime * 6) * 50 + 800;
                splitCamera.position.y = Math.cos(curTime * 8) * 25 + 650;

                splitCamera.angle = Math.cos(curTime * 2) * 2.5;
            };

            for (obj in uiGroup)
            {
                FlxTween.cancelTweensOf(obj);

                obj.alpha = 0;
            }

            updateFunc(0);

            camGame.snapToTarget();
            splitCamera.snapToTarget();
            
            camGame.zoom = camGame.targetZoom = 0.4;
            camGame.width = FlxG.width / 2;
            camGame.zoomSpeed = 4;
            camGame.bopModulo = 0;

            splitCamera.zoomSpeed = 4;

        case 921:
            subtitle.text = 'EAEAHGAH';

        case 922:
            subtitle.text = 'MHMHMHMMHA';

        case 923:
            subtitle.text = 'UGHHHHHHH';

        case 924:
            subtitle.text = 'uwu i\'m furry guys';

        case 936:
            camGame.targetZoom = 0.3;

            splitCamera.targetZoom = 0.8;

            FlxTween.tween(dadStrumLine, {speed: 3}, Conductor.secCrochet * 2, {ease: FlxEase.cubeOut});

        case 952:
            camGame.targetZoom = 0.25;

            splitCamera.targetZoom = 0.6;
            
            FlxTween.tween(dadStrumLine, {speed: 4}, Conductor.secCrochet * 2, {ease: FlxEase.cubeOut});

        case 964:
            camGame.targetZoom = 0.2;

            FlxTween.tween(dadStrumLine, {speed: 5}, Conductor.secCrochet * 2, {ease: FlxEase.cubeOut});

        case 968:
            camGame.tweenZoom(0.4, Conductor.secCrochet * 16);
            camGame.shake(0.0125, Conductor.secCrochet * 16);

            FlxTween.tween(dadStrumLine, {speed: 50}, Conductor.secCrochet * 16);

            splitCamera.tweenZoom(1.25, Conductor.secCrochet * 16);

        case 984:
            changeCharacter(bf, 'bfAir');

            camGame.cancelZoomTween();
            camGame.targetZoom = 0.3;

            FlxTween.tween(camGame, {alpha: 0.25, width: FlxG.width}, Conductor.secCrochet, {ease: FlxEase.cubeOut});

            FlxTween.cancelTweensOf(dadStrumLine);

            dadStrumLine.speed = 2;

            FlxTween.tween(splitCamera, {x: FlxG.width / 4}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

            speed = 1;

            FlxTween.tween(game, {speed: 10}, Conductor.secCrochet * 64);

        case 1000:
            splitCamera.targetZoom = 0.9;

        case 1016:            
            splitCamera.targetZoom = 0.8;

        case 1032:
            changeCharacter(bf, 'bfScared');

            splitCamera.targetZoom = 0.7;

        case 1044:
            FlxTween.tween(splitCamera, {y: FlxG.height, alpha: 0}, Conductor.secCrochet * 4, {ease: FlxEase.cubeIn, onComplete: _ -> splitCamera.exists = false});
            FlxTween.tween(splitCamera, {x: FlxG.height * 0.6}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

            FlxTween.tween(splitCamera.flashSprite, {rotation: 5}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

            FlxTween.tween(camGame, {alpha: 1}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

        case 1048:
            camGame.shake(0.005, Conductor.secCrochet * 224);
            camHUD.shake(0.0025, Conductor.secCrochet * 128);
            splitCamera.shake(0.005, Conductor.secCrochet * 128);

            updateFunc = null;

            allowCameraMoving = true;

            camGame.tweenZoom(0.5, Conductor.secCrochet * 32);

        case 1080:
            camGame.tweenZoom(1, Conductor.secCrochet * 16);

        case 1096:
            camGame.tweenZoom(0.3, Conductor.secCrochet * 16);

        case 1111:
            epicBars(FlxG.height / 2);

        case 1112:
            epicBars(0);

            FlxTween.cancelTweensOf(splitCamera);
            FlxTween.cancelTweensOf(splitCamera.flashSprite);

            allowCameraMoving = false;

            camGame.reset();
            splitCamera.reset();

            splitCamera.x = -FlxG.width;
            splitCamera.y = FlxG.height / 2;
            splitCamera.alpha = 1;
            splitCamera.flashSprite.rotation = 0;
            splitCamera.width = FlxG.width;
            splitCamera.height = FlxG.height / 2;
            splitCamera.exists = true;
            splitCamera.targetAngle = -2.5;

            updateFunc = elapsed -> {
                splitCamera.position.x = Math.sin(curTime * 2) * 50 + 325;
                splitCamera.position.y = Math.cos(curTime * 4) * 50 + 825;
            };

            camGame.height = FlxG.height / 2;
            camGame.targetZoom = 0.5;
            camGame.x = FlxG.width;
            camGame.y = 0;
            camGame.angle = 2.5;
            camGame.position.x = -100;
            camGame.position.y = 500;

            FlxTween.tween(camGame, {x: 0}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});
            FlxTween.tween(splitCamera, {x: 0}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});

        case 1176:
            changeCharacter(bf, 'bfAir');

            FlxTween.tween(camGame, {height: FlxG.height}, Conductor.secCrochet * 4, {ease: FlxEase.cubeOut});
            FlxTween.tween(camHUD, {alpha: 0}, Conductor.secCrochet * 16, {ease: FlxEase.cubeOut});
            FlxTween.tween(splitCamera, {y: FlxG.height, alpha: 0}, Conductor.secCrochet * 2, {ease: FlxEase.cubeIn, onComplete: _ -> splitCamera.exists = false});

            updateFunc = null;

            camGame.position.set(300, 500);
            camGame.targetZoom = 0.3;

        case 1272:
            camGame.tweenZoom(2, Conductor.secCrochet * 96);
            camGame.fade(FlxColor.BLACK, Conductor.secCrochet * 96);
    }
}

skipCountdown = true;

function onUpdate(elapsed:Float)
{    
    final time = Conductor.time / Conductor.crochet / 2;

    dad.y = Math.sin(time) * 100;
    dad.angle = Math.cos(time);

    curTime += elapsed;

    if (updateFunc != null)
        updateFunc(elapsed);
}

function onNoteHit(note:Note, character:Character)
    if (character.type == 'opponent')
        if (health > 1)
            health *= 0.995;