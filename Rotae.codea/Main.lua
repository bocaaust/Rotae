-- Rotae
displayMode(FULLSCREEN)
-- Use this function to perform your initial setup
function setup()
    tasks = {11111,22222}
    font("KozGoPro-Light")
    idName = {}
    idTime = {}
    idName[tasks[1]] = "test"
    idTime[tasks[1]] = 30
    idName[tasks[2]] = "test2"
    idTime[tasks[2]] = 30
    starti = vec2(0,0)
    i = 0
    total = 0
    x = 0
    screen = 1
    rollodex = vec3(0,30)
    touching = 0
    rectMode(CORNER)
    hours=0
    increase=0
    decrease=0
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(253, 202, 150, 255)
    if screen == 0 then
    --points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH*3/4,HEIGHT/2)}
    start = true
    stroke(255)
    fill(125)
    ellipse(WIDTH/2,HEIGHT/2,HEIGHT/2)
    i = 0
    total = 0
--summation of times into total
    for i,x in ipairs(tasks) do
        total = total + idTime[x]
    end
    starti = vec2(0,0)
if #tasks > 1 then
    while i <= math.pi*2+.03 do
        if start then
            start = false
            starti.x = i
            starti.y = starti.y + 1
            points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH/2+HEIGHT/4*math.cos(i),HEIGHT/2+HEIGHT/4*math.sin(i))}
            math.randomseed(tasks[starti.y])
            temp = color(math.random(150,255),math.random(150,255),math.random(150,255),255)
            stroke(temp)
            fill(temp)
        else
--comparison between position difference over total of circle and time section over summation of time
        if i-starti.x > 0 then
            if (i-starti.x)/(math.pi*2) >= (idTime[tasks[starti.y]]/total) then
                start = true
                points[3] = vec2(WIDTH/2+HEIGHT/4*math.cos(i),HEIGHT/2+HEIGHT/4*math.sin(i))
            end
        end
        end
            if start then
                --line(points[1].x,points[1].y,points[2].x,points[2].y)
                line(points[1].x,points[1].y,points[3].x,points[3].y)
                line(points[3].x,points[3].y,points[2].x,points[2].y)
                fontSize(25)
                --fill(math.random(0,255),math.random(0,255),math.random(0,255),255)
                text(idName[tasks[starti.y]],(points[2].x+points[3].x)/2,(points[2].y+points[2].y+points[1].y)/3+(starti.y%2+1)*(-1)*HEIGHT/5+HEIGHT/5*1.5)
            end
        ellipse(WIDTH/2+HEIGHT/4*math.cos(i),HEIGHT/2+HEIGHT/4*math.sin(i),10)
        i = i +.01
    end
else
    fontSize(40*6)
        text(idName[tasks[1]],WIDTH/2,HEIGHT/2)
    end
   end

   --Check if we are on select screen
    if screen == 1 then

        --Check if touch ended
        if CurrentTouch.state == ENDED then
            touching = 0
        else

        --Check if we are touching the right half of the screen
        if CurrentTouch.x > WIDTH /2 then

            --Check if we are touching the plus or the minus
            if CurrentTouch.y > HEIGHT/2 then
                --"+"
                touching = 1
            else
                -- "-"
                touching = 2
            end
        end
    
    end

        --Set stroke color to white and a thin line
        stroke(255)
        strokeWidth(5)

        --Pastel green fill
        fill(202,253,150,255)

        --If touching rectangle, make it darker
        if touching == 1 then
            fill(202,253,150,230)
        end
        rect(WIDTH/2,HEIGHT/2,WIDTH/2,HEIGHT/2)
        fill(202,253,150,255)
        if touching == 2 then
            fill(202,253,150,230)
        end
        rect(WIDTH/2,0,WIDTH/2,HEIGHT/2)

        --Pastel yellow fill
        fill(253,253,150,255)
        rect(0,0,WIDTH/2,HEIGHT/4)
        fill(255)
        fontSize(70)
        --Draw instructional text
        textMode(CORNER)
        text("Estimate",WIDTH/8,HEIGHT*7.1/8-HEIGHT*.3/8)
        text("how long",WIDTH/8,HEIGHT*6.4/8-HEIGHT*.3/8)
        text("your task",WIDTH/8,HEIGHT*5.7/8-HEIGHT*.3/8)
        text("will take",WIDTH/8,HEIGHT*5/8-HEIGHT*.3/8)

        --Dividing line
        line(0,HEIGHT/2,WIDTH/2,HEIGHT/2)
        textMode(CENTER)
        fontSize(180)
        text("+",WIDTH*3/4,HEIGHT/4*3)
        fontSize(240)
        text("-",WIDTH*3/4,HEIGHT/4)

    end
    
end

