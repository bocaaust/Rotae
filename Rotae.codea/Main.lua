-- Rotae
displayMode(FULLSCREEN)
-- Use this function to perform your initial setup
function setup()
    tasks = {11111,22222,3333}
    font("KozGoPro-Light")
    idName = {}
    idTime = {}
    idName[tasks[1]] = "test"
    idTime[tasks[1]] = 30
    idName[tasks[2]] = "test2"
    idTime[tasks[2]] = 30
    idName[tasks[3]] = "test3"
    idTime[tasks[3]] = 30
    starti = vec2(0,0)
    i = 0
    total = 0
    x = 0
    screen = 0
    rollodex = vec3(0,30)
    touching = 0
    rectMode(CORNER)
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
                stroke(255)
                strokeWidth(5)
                line(WIDTH/2,HEIGHT/2,points[2].x,points[2].y)
                line(WIDTH/2,HEIGHT/2,WIDTH/2+HEIGHT/4*math.cos(i),HEIGHT/2+HEIGHT/4*math.sin(i))
                --line(points[3].x,points[3].y,points[2].x,points[2].y)
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
    if screen == 1 then
        if CurrentTouch.state == ENDED then
            touching = 0
        else
        if CurrentTouch.x > WIDTH /2 then
            if CurrentTouch.y > HEIGHT/2 then
                --"+"
                touching = 1
            else
                -- "-"
                touching = 2
            end
        end
        end
        stroke(255)
        strokeWidth(5)
        fill(202,253,150,255)
        if touching == 1 then
            fill(202,253,150,230)
        end
        rect(WIDTH/2,HEIGHT/2,WIDTH/2,HEIGHT/2)
        fill(202,253,150,255)
        if touching == 2 then
            fill(202,253,150,230)
        end
        rect(WIDTH/2,0,WIDTH/2,HEIGHT/2)
        fill(253,253,150,255)
        rect(0,0,WIDTH/2,HEIGHT/4)
        fill(255)
        fontSize(70)
        textMode(CORNER)
        text("Estimate",WIDTH/8,HEIGHT*7.1/8-HEIGHT*.3/8)
        text("how long",WIDTH/8,HEIGHT*6.4/8-HEIGHT*.3/8)
        text("your task",WIDTH/8,HEIGHT*5.7/8-HEIGHT*.3/8)
        text("will take",WIDTH/8,HEIGHT*5/8-HEIGHT*.3/8)
        line(0,HEIGHT/2,WIDTH/2,HEIGHT/2)
        textMode(CENTER)
        fontSize(180)
        text("+",WIDTH*3/4,HEIGHT/4*3)
        fontSize(240)
        text("-",WIDTH*3/4,HEIGHT/4)

    end
    
end

