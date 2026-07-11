import funkin.visuals.shaders.FXShader;

final wavyShader:FXShader = new FXShader('wavy');

function onCreate()
    shader.set({r: 1.25, g: 0.75, b: 0.75});

function postCreate()
{
    wavyShader.set({
        speed: 5,
        frequency: 10,
        amplitude: 0.25
    });

    stage.get('bg').shader = wavyShader;
}

function onUpdate(elapsed:Float)
{
    wavyShader.setFloat('time', Conductor.secTime);
}