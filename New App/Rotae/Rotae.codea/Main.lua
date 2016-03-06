-- Rotae
displayMode(FULLSCREEN)
-- Use this function to perform your initial setup
function setup()
    --tasks = {11111,22222,333333}
    tasks = {}
    --font("KozGoPro-Light")
    idName = {}
    input = ""
    idTime = {}
    starti = vec3(0,0,0)
    i = 0
    total = 0
    speech.rate = .3
    cTime = 0
    x = 0
    screen = 1
    touching = 0
    rectMode(CORNER)
    hours=0
    increase=0
    decrease=0
    temp = color(0,0,0,255)
    hasTouched = false
    stopgo = true
    timego = readLocalData("timego",0)
    touchbegan = true
    receive()
    if #tasks > 0 then
        screen = 0
    end
    showWindow = false
end

function receive()
    size = readLocalData("size",-1)
    if size > 0 then
        for i = 1,size do
            x = readLocalData(i.."id",0)
            if x ~= 0 then
                tasks[i] = x
                idName[x] = readLocalData(i.."name","")
                idTime[x] = readLocalData(i.."time",0)
            end
        end
    end

end

-- This function gets called once every frame
function draw()
    if CurrentTouch.state == ENDED then touchbegan  = true end
    if CurrentTouch.state == BEGAN and hasTouched == false then
        hasTouched = true
    end
    -- This sets a dark background color
    background(253, 202, 150, 255)
    
    --Check if we are on the task screen
    if screen == 0 then
        --points = {vec2(WIDTH/2,HEIGHT/2),vec2(WIDTH*3/4,HEIGHT/2)}
        start = true
        
        --Draw circle with white outline
        stroke(255)
        fill(125)
        ellipse(WIDTH/2,HEIGHT/2,HEIGHT/2)
        
        i = 0
        total = 0
        --summation of times into total
        counter = 1
        for i,x in ipairs(tasks) do
            total = total + idTime[tasks[i]]
            textMode(CORNER)
            --Pick random seed based off of id
            math.randomseed(x)
            fill(0,0,0,125)
            rect(WIDTH/9.7,HEIGHT-HEIGHT/16*i-HEIGHT/64,WIDTH/27+textSize(idName[tasks[i]]),HEIGHT/17)
            --Pick random color (150-255) is in pastel range
            temp = color(math.random(150,255),math.random(150,255),math.random(150,255),255)
            stroke(temp)
            fill(temp)
            --Print task name
            text(idName[x].." ",WIDTH/8,HEIGHT-HEIGHT/16*counter)
            --reset text mode
            counter = counter + 1
        end
        fill(0,0,0,125)
        textMode(CORNER)
        rect(WIDTH/9.7,HEIGHT-HEIGHT/16*counter-HEIGHT/64,WIDTH/27+textSize("+"),HEIGHT/17)
        fill(255)
        text("+",WIDTH/8,HEIGHT-HEIGHT/16*counter)
        if CurrentTouch.x <= WIDTH/9.7+textSize("+")+WIDTH/27 and CurrentTouch.y > HEIGHT-HEIGHT/16*counter-HEIGHT/64 and CurrentTouch.y < HEIGHT-HEIGHT/16*counter-HEIGHT/64 + HEIGHT/17 and CurrentTouch.state == ENDED then
            screen = 1
        end
        textMode(CENTER)
        starti = vec3(0,0,0)
        
        --Check if we have more than one task
        if #tasks > 1 then
            while i <= math.pi*2+.03 do
                if start then
                    start = false
                    starti.x = i
                    starti.y = starti.y + 1
                    points = {vec2(WIDTH/2,HEIGHT/2),vec2(i,i)}
                    if starti.y > #tasks then
                        starti.y = #tasks
                    end
                    --Pick random seed based off of id
                    math.randomseed(tasks[starti.y])
                    
                    --Pick random color (150-255) is in pastel range
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
                    --Pick random seed based off of id
                    math.randomseed(tasks[starti.y])
                    
                    --Pick random color (150-255) is in pastel range
                    temp = color(math.random(150,255),math.random(150,255),math.random(150,255),255)
                    stroke(255)
                    fill(temp)
                    strokeWidth(5)
                    line(WIDTH/2,HEIGHT/2,WIDTH/2+HEIGHT/4*math.cos((points[2].x)+(timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin((points[2].y)+(timego-cTime)/(total*60)*2*math.pi))
                    line(WIDTH/2,HEIGHT/2,WIDTH/2+HEIGHT/4*math.cos(i+(timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin(i+(timego-cTime)/(total*60)*2*math.pi))
                    --line(WIDTH/2,HEIGHT/2,WIDTH/2+HEIGHT/4*math.cos(i),HEIGHT/2+HEIGHT/4*math.sin(i))
                    --line(points[3].x,points[3].y,points[2].x,points[2].y)
                    fontSize(25)
                    --fill(math.random(0,255),math.random(0,255),math.random(0,255),255)
                    --text(idName[tasks[starti.y]],(points[2].x+points[3].x)/2,(points[2].y+points[3].y+points[1].y)/3)
                end
                --Pick random seed based off of id
                math.randomseed(tasks[starti.y])
                
                --Pick random color (150-255) is in pastel range
                temp = color(math.random(150,255),math.random(150,255),math.random(150,255),255)
                stroke(temp)
                fill(temp)
                strokeWidth(0)
                if (i-starti.z)/(2*math.pi) >= 30/total then
                    if WIDTH/2+HEIGHT/4*math.cos(i+(timego-cTime)/(total*60)*2*math.pi) == WIDTH/2+HEIGHT/4 then
                        --stops time
                        stopgo = false
                        temp2 = window2()
                        showWindow = true
                    end
                    fill(0,0,0,130)
                    ellipse(WIDTH/2+HEIGHT/4*math.cos(i+(timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin(i+(timego-cTime)/(total*60)*2*math.pi),20)
                    starti.z = i
                else
                    ellipse(WIDTH/2+HEIGHT/4*math.cos(i+(timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin(i+(timego-cTime)/(total*60)*2*math.pi),10)
                end
                i = i +.01
            end
        else
            while i <= math.pi*2+.07 do
                --if #tasks == 1 then
                --Pick random seed based off of id
                math.randomseed(tasks[1])
                
                --Pick random color (150-255) is in pastel range
                temp = color(math.random(150,255),math.random(150,255),math.random(150,255),255)
                stroke(temp)
                fill(temp)
                strokeWidth(0)
                if (i-starti.z)/(2*math.pi) >= 30/total then
                    if WIDTH/2+HEIGHT/4*math.cos(i+(timego-cTime)/(total*60)*2*math.pi) == WIDTH/2+HEIGHT/4 then
                    --stops time
                        stopgo = false
                        temp2 = window2()
                        showWindow = true
                    end

                    fill(0,0,0,130)
                    ellipse(WIDTH/2+HEIGHT/4*math.cos(i)+math.cos((timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin(i)+math.sin((timego-cTime)/(total*60)*2*math.pi),20)
                    starti.z = i
                else
                    ellipse(WIDTH/2+HEIGHT/4*math.cos(i)+math.cos((timego-cTime)/(total*60)*2*math.pi),HEIGHT/2+HEIGHT/4*math.sin(i)+math.sin((timego-cTime)/(total*60)*2*math.pi),10)
                end
                -- fontSize(40)
                --text(idName[tasks[1]],WIDTH/2,HEIGHT/2)
                i = i +.01
                -- else
                --  fill(255, 255, 255, 255)
                --  fontSize(40)
                --   text("Tap + to add a task",WIDTH/2,HEIGHT/2)
                --  screen = 1
                -- end
            end
        end
        if #tasks == 0 then
            screen = 1
        end
        --checks time flag
        if stopgo then
            --iterates a frame forward
            --timego = timego +1/60
            timego = timego+1
            tint(255)
            sprite("Project:Stop",WIDTH/2,HEIGHT/2,HEIGHT/3)
            if CurrentTouch.state == BEGAN and CurrentTouch.x > WIDTH/2-HEIGHT/4 and CurrentTouch.x < WIDTH/2+HEIGHT/4 and CurrentTouch.y > HEIGHT/4 and CurrentTouch.y < HEIGHT*3/4 and touchbegan then
                touchbegan = false
                stopgo = false
            end
        else
            if CurrentTouch.state == BEGAN and CurrentTouch.x > WIDTH/2-HEIGHT/4 and CurrentTouch.x < WIDTH/2+HEIGHT/4 and CurrentTouch.y > HEIGHT/4 and CurrentTouch.y < HEIGHT*3/4 and touchbegan then
                touchbegan = false
                stopgo = true
            end
            sprite("Project:Go",WIDTH/2,HEIGHT/2,HEIGHT/3)
        end
        sprite("Project:HandArrow",WIDTH*3/4,HEIGHT/2.18,WIDTH/8)
    end
    
    --Check if we are on select screen
    if screen == 1 then
        --Check if touch ended
        if CurrentTouch.state == ENDED then
            if touching == 3 and hours > 0 then
                --Process Event
                tasks[#tasks+1] = math.random(100000,999999)
                --Convert minutes to seconds
                idTime[tasks[#tasks]] = hours*60
                screen = 2
            end
            touching = 0
            
            --Check flags
            if increase == 1 then
                --add 15 minute interval
                hours = hours+ 0.25
                --reset flag
                increase=0
            end
            
            --Decrease is more complicated - we have to check if
            --the hours is 0.25 or less to avoid negatives
            
            if decrease == 1 and hours >=0.25 then
                --get rid of 30 minute interval
                hours = hours- 0.25
                --reset flag
                decrease=0
            end
        else
            --Check if we are touching the right half of the screen
            if CurrentTouch.x > WIDTH /2 then
                
                --Check if we are touching the plus or the minus
                if CurrentTouch.y > HEIGHT/2 then
                    --"+"
                    touching = 1
                    
                    --Set "increase" flag to ON
                    increase=1
                    decrease=0
                else
                    -- "-"
                    touching = 2
                    
                    --Set "decrease" flag to ON
                    --"Flags" prevent unexpected results in increase/decrease
                    decrease=1
                    increase=0
                end
                
                --Check if touching "DONE" button
            elseif CurrentTouch.y <= HEIGHT/4 then
                touching = 3
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
        
        --Plus rectangle
        rect(WIDTH/2,HEIGHT/2,WIDTH/2,HEIGHT/2)
        
        --Pastel green fill
        fill(202,253,150,255)
        if touching == 2 then
            fill(202,253,150,230)
        end
        
        --Minus rectangle
        rect(WIDTH/2,0,WIDTH/2,HEIGHT/2)
        
        --Pastel yellow fill
        fill(253,253,150,255)
        if touching == 3 and hasTouched then
            fill(223, 223, 119, 255)
        end
        rect(0,0,WIDTH/2,HEIGHT/4)
        fill(255)
        fontSize(70)
        --Draw instructional text
        textMode(CORNER)
        text("Estimate",WIDTH/8,HEIGHT*7.1/8-HEIGHT*.3/8)
        text("how long",WIDTH/8,HEIGHT*6.4/8-HEIGHT*.3/8)
        text("your task",WIDTH/8,HEIGHT*5.7/8-HEIGHT*.3/8)
        text("will take",WIDTH/8,HEIGHT*5/8-HEIGHT*.3/8)
        
        --Draw Time
        textMode(CENTER)
        text((math.floor(hours*60)).." min.",WIDTH/4,HEIGHT/2.7)
        textMode(CORNER)
        
        -- Draw "DONE"
        text("DONE",WIDTH/6.8,HEIGHT/11)
        
        --Dividing line
        line(0,HEIGHT/2,WIDTH/2,HEIGHT/2)
        textMode(CENTER)
        
        --Draw +
        fontSize(180)
        text("+",WIDTH*3/4,HEIGHT/4*3)
        
        --Draw -
        fontSize(240)
        text("-",WIDTH*3/4,HEIGHT/4)
        
    end
    
    --Name task screen
    if screen ==2 then
        
        --Draw header
        fill(0)
        text("Enter your task here: ",WIDTH/2,2*HEIGHT/3)
        
        --Show keyboard
        if isKeyboardShowing()== false then
            if textSize(input) > 0 then
                --  if string.find(input,RETURN) ~= nil then
                
                -- end
                idName[tasks[#tasks]] = string.gsub(input,RETURN,"")
                screen = 0
                hideKeyboard()
                input = ""
                showKeyboard()
                hideKeyboard()
            else
                showKeyboard()
            end
        end
        
        --Get keyboard input
        input = keyboardBuffer()
        
        --Draw input box
        fill(255)
        stroke(125)
        rect(WIDTH/4,HEIGHT*3/4-HEIGHT/32,WIDTH/2,HEIGHT/16)
        fill(0)
        fontSize(20)
        text(input,WIDTH/2,HEIGHT/4*3)
    end
    
    if showWindow then
        temp2:draw()
        showWindow = temp2:canClose()
    end
backup()
end

function backup()
    saveLocalData("size",#tasks)
    for i,x in ipairs(tasks) do
        saveLocalData(i.."id",x)
        saveLocalData(i.."name",idName[x])
        saveLocalData(i.."time",idTime[x])
    end
    saveLocalData("timego",timego)
end


function keyboard(key)
    --Hide the keyboard and go to main screen
    --  if RETURN entered
    if key == RETURN then
        idName[tasks[#tasks]] = string.gsub(input,RETURN,"")
        screen = 0
        hideKeyboard()
        input = ""
    end
end

window1 = class()

function window1:init(tasks,identity,names,times)
    showing = true
    deleting = false
    t = tasks
    id = identity
    n = names
    ti = times
    speech.say("Time to take a break")
end

function window1:draw()
    fill(0,0,0,35)
    rectMode(CORNER)
    rect(0,0,WIDTH,HEIGHT)
    fill(255)
    rectMode(CENTER)
    rect(WIDTH/2,HEIGHT*3/4,WIDTH/8,HEIGHT/4)
    fill(0)
    text("You Completed a Task",WIDTH/2,HEIGHT/4*3.4)
    text("Do You Need More Time",WIDTH/2,HEIGHT/4*3)
end

function window1:canClose()
    if CurrentTouch.state == BEGAN then
        showing = false
    end
    return showing
end

function window1:close()
    if deleting then
        for i,x in ipairs(t) do
            if x == id then
                table.remove(n,x)
                table.remove(ti,x)
                table.remove(t,i)
                break
            end
        end
    end
    return t
end

function window1:close2()
    return n
end

function window1:close3()
    return ti
end



window2 = class()

function window2:init()
showing = true
speech.say("Time to take a break")
end

function window2:draw()
fill(0,0,0,35)
rectMode(CORNER)
rect(0,0,WIDTH,HEIGHT)
fill(255)
rectMode(CENTER)
rect(WIDTH/2,HEIGHT*3/4,WIDTH/8,HEIGHT/4)
fill(0)
text("Time to take a break",WIDTH/2,HEIGHT/4*3.4)
text("Tap to Continue",WIDTH/2,HEIGHT/4*3)
end

function window2:canClose()
if CurrentTouch.state == BEGAN then
showing = false
end
return showing
end

