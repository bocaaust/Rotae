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
        total = total + idTime[tasks]
    end
    starti = vec2(0,0)
if #tasks > 1 then
    while i <= math.pi*2 do
        if start then
            start = false
            starti.x = i
            starti.y = starti.y + 1
            points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH/2+HEIGHT/2*math.cos(i),HEIGHT/2+HEIGHT/2*math.sin(i))}
        else
            if (starti.x + i)/(math.pi*2) >= (idTime[tasks[starti.y]]/total) then
                start = true
                points[3] = vec2(WIDTH/2+HEIGHT/2*math.cos(i),HEIGHT/2+HEIGHT/2*math.sin(i))
            end
        end
            if start then
                
            end
        i = i +.1
    end
else
    fontSize(40)
        text(idName[tasks[1]],WIDTH/2,HEIGHT/2)
    end
    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    
end

