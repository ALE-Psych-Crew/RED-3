import flixel.addons.effects.FlxTrail;

var dadTrail:FlxTrail;

function postCreate()
{
    dad.config.bopAnimations = ['idle', null, null, null];

    bf.config.bopAnimations = [null, null, 'idle', null];
    bf.config.sustainAnimation = false;

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
    }
}

// startTime = Conductor.beatToTime(256);

spawnNotes = startTime <= 0;

skipCountdown = true;

function onUpdate(elapsed:Float)
{
    final time = Conductor.time / Conductor.crochet / 2;

    dad.y = Math.sin(time) * 100;

    dad.angle = Math.cos(time);
}

function onNoteHit(note:Note, character:Character)
    if (character.type == 'opponent')
        if (health > 1)
            health *= 0.995;