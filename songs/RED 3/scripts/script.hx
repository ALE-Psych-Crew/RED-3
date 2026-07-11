import flixel.addons.effects.FlxTrail;

var dadTrail:FlxTrail;

cacheCharacter('bfScared');

function postCreate()
{
    dad.config.bopAnimations = ['idle', null, null, null];

    addBehindDad(dadTrail = new FlxTrail(dad, null, 5, 10));

    camGame.zoomSpeed = 4;
    camGame.angleSpeed = 4;
    camHUD.alpha = 0;

    camGame.fade(FlxColor.BLACK, 0);

    opponentStrumLines.members[0].alpha = 0.5;
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
    }
}

startTime = Conductor.beatToTime(0);

spawnNotes = startTime <= 0;

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