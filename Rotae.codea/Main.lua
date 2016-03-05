-- Rotae

-- Use this function to perform your initial setup
function setup()
    tasks = {11111}
    idName = {}
    idName[tasks[1]] = "test"
    idTime[tasks[1]] = 30
    x = 0
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(151, 171, 171, 255)
    points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH*3/4,HEIGHT/2)}
    start = true
    ellipse(WIDTH/2,HEIGHT/2,HEIGHT/2)
    i = 0
    total = 0
    for i,x in ipairs(tasks) do
        idTime[tasks]
    end
    while i <= math.pi*2 do
        if start then
            start = false
            points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH/2+HEIGHT/2*math.cos(i),HEIGHT/2+HEIGHT/2*math.sin(i))}
        end
        i = i +.5
    end
    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    
end

