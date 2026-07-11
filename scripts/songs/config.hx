import funkin.visuals.shaders.FXShader;

public final shader:FXShader = new FXShader('global');

shader.set({bloom: 1, r: 1, g: 1, b: 1});

final downBar:FlxSprite = add(new FlxSprite(0, FlxG.height).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK));

final upBar:FlxSprite = add(new FlxSprite(0, -FlxG.height).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK));

public function epicBars(?offset:Float = 0, ?time:Float, ?ease:FlxEase)
{
    time ??= Conductor.secCrochet;
    ease ??= FlxEase.cubeOut;

    for (index => bar in [upBar, downBar])
    {
        FlxTween.cancelTweensOf(bar);
        FlxTween.tween(bar, {y: index == 0 ? offset - FlxG.height : FlxG.height - offset}, time, {ease: ease});
    }
}

function postCamerasInit()
{
    camGame.setShaders([shader]);

    downBar.camera = upBar.camera = camOther;
}

var opponentNotes:Int = 0;
var playerNotes:Int = 0;

final cameraMatrix:Array<Array<Float>> = [
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 0]
];

function onNoteHit(note:Note, character:Character)
{
    if (note.type == 'arrow')
    {
        if (character.type == 'opponent')
        {
            opponentNotes++;

            updateScoreText();
        } else {
            playerNotes++;
        }

        if (character != cameraTarget)
            return;

        final data:Array<Float> = cameraMatrix[note.data];

        final factor:Float = 25;

        camGame.offset.set(data[0] * factor, data[1] * factor);
    }
}

function postScoreTextUpdate()
    scoreText.text += '    Notes: ' + opponentNotes + ' / ' + playerNotes;