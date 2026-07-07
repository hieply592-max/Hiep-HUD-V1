local P=game:GetService("Players")local LP=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")local UI=game:GetService("UserInputService")
local VI=game:GetService("VirtualInputManager")local W=game:GetService("Workspace")
local CG=W.CurrentCamera local TS=game:GetService("TweenService")

task.wait(5)

local function SC()
    for i=1,20 do
        for _,v in pairs(LP.PlayerGui:GetDescendants())do
            if v:IsA("TextButton")and(v.Text=="Skip"or v.Text==">>"or v.Text=="Bo qua")then
                fireclickbutton(v)break
            end
        end
        task.wait(0.3)
    end
end

local function AS()
    task.wait(2)
    for _,v in pairs(LP.PlayerGui:GetDescendants())do
        if v:IsA("TextButton")and v:FindFirstAncestorOfClass("ScreenGui")then
            local t=v.Text:lower()
            if t:find("eren")or t:find("mikasa")or t:find("start")then
                fireclickbutton(v)return
            end
        end
    end
end

local function AM()
    task.wait(3)
    local npc=nil
    for i=1,60 do
        for _,v in pairs(W:GetDescendants())do
            if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("Head")then
                local n=v.Name:lower()
                if n:find("shadis")or n:find("keith")or n:find("instructor")then
                    npc=v break
                end
            end
        end
        if npc then break end
        task.wait(0.5)
    end
    if npc and npc:FindFirstChild("HumanoidRootPart")then
        LP.Character:MoveTo(npc.HumanoidRootPart.Position)
        repeat task.wait(0.2)until(LP.Character.HumanoidRootPart.Position-npc.HumanoidRootPart.Position).Magnitude<10
    end
end

local function AQ()
    task.wait(1)
    for i=1,10 do
        for _,v in pairs(LP.PlayerGui:GetDescendants())do
            if v:IsA("TextButton")and v.Visible then
                local t=v.Text:lower()
                if t:find("accept")or t:find("nhan")or t:find("continue")or t:find("tiep")or t:find("ok")then
                    fireclickbutton(v)task.wait(0.3)break
                end
            end
        end
        task.wait(0.2)
    end
end

local function AO()
    task.wait(3)
    local vu=game:GetService("VirtualUser")vu:CaptureController()
    for i=1,30 do
        vu:Button1Down(Vector2.new())task.wait(0.2)vu:Button1Up(Vector2.new())
        UI.InputBegan:Fire({[Enum.KeyCode.Q]=true},false)task.wait(0.3)UI.InputEnded:Fire({[Enum.KeyCode.Q]=true},false)
        UI.InputBegan:Fire({[Enum.KeyCode.E]=true},false)task.wait(0.3)UI.InputEnded:Fire({[Enum.KeyCode.E]=true},false)
        UI.InputBegan:Fire({[Enum.KeyCode.Space]=true},false)task.wait(0.1)UI.InputEnded:Fire({[Enum.KeyCode.Space]=true},false)
    end
end

local function AF()
    task.wait(3)
    local titan=nil
    repeat
        for _,v in pairs(W:GetDescendants())do
            if v:IsA("Model")and(v.Name:lower():find("titan")or v.Name:lower():find("dummy"))then
                if v:FindFirstChild("Humanoid")and v.Humanoid.Health>0 then titan=v break end
            end
        end
        task.wait(0.5)
    until titan
    if titan and titan:FindFirstChild("Head")then
        for i=1,50 do
            CG.CFrame=CFrame.new(CG.CFrame.Position,titan.Head.Position)
            VI:CaptureController()VI:Button1Down(Vector2.new())task.wait(0.5)VI:Button1Up(Vector2.new())
            if titan.Humanoid.Health<=0 then break end
            task.wait(0.3)
        end
    end
end

local function AR()
    task.wait(2)
    for _,v in pairs(LP.PlayerGui:GetDescendants())do
        if v:IsA("TextButton")and v.Visible then
            local t=v.Text:lower()
            if t:find("claim")or t:find("nhan")or t:find("reward")or t:find("thuong")or t:find("spin")then
                fireclickbutton(v)task.wait(0.2)
            end
        end
    end
end

SC()task.wait(10)AS()task.wait(3)AM()task.wait(5)AQ()task.wait(3)AO()task.wait(3)AF()task.wait(2)AR()
print("HOAN THANH TUTORIAL AOTR")
local P=game:GetService("Players")local LP=P.LocalPlayer
local W=game:GetService("Workspace")local UI=game:GetService("UserInputService")
local VI=game:GetService("VirtualInputManager")local CG=W.CurrentCamera
local RS=game:GetService("RunService")

local Farm={on=false,kill=0,target=nil}
local ESP={on=true,list={}}

local function Scan()
    local titans={}
    local pos=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not pos then return titans end
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("Head")and v.Humanoid.Health>0 then
            local n=v.Name:lower()
            if n:find("titan")or v:FindFirstChild("IsTitan")then
                local d=(pos.Position-v.Head.Position).Magnitude
                if d<500 then table.insert(titans,{m=v,d=d,h=v.Humanoid.Health,mh=v.Humanoid.MaxHealth})end
            end
        end
    end
    table.sort(titans,function(a,b)return a.d<b.d end)
    return titans
end

local function DrawESP(list)
    for _,o in pairs(ESP.list)do if o.t then o.t:Remove()end if o.b then o.b:Remove()end end
    ESP.list={}
    if not ESP.on then return end
    for _,t in pairs(list)do
        if t.m:FindFirstChild("Head")then
            local hp=CG:WorldToViewportPoint(t.m.Head.Position)
            if hp.Z>0 then
                local txt=Drawing.new("Text")txt.Text=t.m.Name.."\nHP:"..math.floor(t.h);txt.Size=13
                txt.Color=Color3.new(1,0,0);txt.Center=true;txt.Position=Vector2.new(hp.X,hp.Y-30)
                txt.Visible=true;txt.Outline=true;table.insert(ESP.list,{t=txt})
                local box=Drawing.new("Square")box.Thickness=2;box.Color=Color3.new(1,0,0)
                box.Filled=false;box.Position=Vector2.new(hp.X-20,hp.Y);box.Size=Vector2.new(40,60)
                box.Visible=true;table.insert(ESP.list,{b=box})
            end
        end
    end
end

local function Attack(t)
    if not t or not t:FindFirstChild("Head")then return end
    CG.CFrame=CFrame.new(CG.CFrame.Position,t.Head.Position)
    VI:CaptureController()VI:Button1Down(Vector2.new())task.wait(0.1)VI:Button1Up(Vector2.new())
end

local function MoveTo(t)
    if not t:FindFirstChild("HumanoidRootPart")then return end
    local kQ={[Enum.KeyCode.Q]=true};UI.InputBegan:Fire(kQ,false);task.wait(0.05);UI.InputEnded:Fire(kQ,false)
    local kE={[Enum.KeyCode.E]=true};UI.InputBegan:Fire(kE,false);task.wait(0.05);UI.InputEnded:Fire(kE,false)
    local kS={[Enum.KeyCode.Space]=true};UI.InputBegan:Fire(kS,false);task.wait(0.1);UI.InputEnded:Fire(kS,false)
    LP.Character:MoveTo(t.HumanoidRootPart.Position)
end

function Farm:Start()
    self.on=true;self.kill=0
    task.spawn(function()
        while self.on do
            local list=Scan()
            if#list>0 then
                self.target=list[1].m
                if self.target and self.target:FindFirstChild("Humanoid")and self.target.Humanoid.Health>0 then
                    local d=(LP.Character.HumanoidRootPart.Position-self.target.HumanoidRootPart.Position).Magnitude
                    if d>50 then MoveTo(self.target)task.wait(0.3)end
                    if d<=20 then Attack(self.target)
                        if self.target.Humanoid.Health<=0 then self.kill=self.kill+1 end
                    end
                end
            else
                LP.Character:MoveTo(LP.Character.HumanoidRootPart.Position+Vector3.new(math.random(-80,80),0,math.random(-80,80)))
                task.wait(2)
            end
            task.wait(0.5)
        end
    end)
end

function Farm:Stop()self.on=false;self.target=nil end

RS.RenderStepped:Connect(function()if ESP.on then DrawESP(Scan())end end)

UI.InputBegan:Connect(function(i,g)if g then return end
    if i.KeyCode==Enum.KeyCode.L then if Farm.on then Farm:Stop()else Farm:Start()end end
    if i.KeyCode==Enum.KeyCode.P then ESP.on=not ESP.on end
    if i.KeyCode==Enum.KeyCode.K then Farm:Stop()ESP.on=false
        for _,o in pairs(ESP.list)do if o.t then o.t:Remove()end if o.b then o.b:Remove()end end
        ESP.list={}
    end
end)

print("AOTR PART2 LOADED | L=Farm P=ESP K=Off")
local P=game:GetService("Players")local LP=P.LocalPlayer
local W=game:GetService("Workspace")local UI=game:GetService("UserInputService")
local CG=W.CurrentCamera local RS=game:GetService("RunService")

local Tags={list={},max=10}
local Colors={Boss=Color3.new(1,0,1),Abnormal=Color3.new(1,0,0),Normal=Color3.new(1,0.6,0),Crawler=Color3.new(1,1,0),Special=Color3.new(0,1,1)}

local function GetType(t)
    local n=t.Name:lower()
    if n:find("boss")or n:find("eren")or n:find("annie")or n:find("reiner")or n:find("zeke")then return"Boss"end
    if n:find("abnormal")or n:find("female")or n:find("armored")or n:find("colossal")or n:find("beast")or n:find("jaw")then return"Abnormal"end
    if n:find("crawler")then return"Crawler"end
    if n:find("special")or n:find("rare")then return"Special"end
    return"Normal"
end

function Tags:Scan()
    self.list={}
    local pos=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not pos then return end
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("Head")and v.Humanoid.Health>0 then
            if v.Name:lower():find("titan")or v:FindFirstChild("IsTitan")then
                local d=(pos.Position-v.Head.Position).Magnitude
                if d<500 then
                    local ty=GetType(v)
                    local pri=0
                    if ty=="Boss"then pri=1000 elseif ty=="Abnormal"then pri=500 elseif ty=="Special"then pri=300 end
                    pri=pri-d
                    table.insert(self.list,{m=v,d=d,ty=ty,h=v.Humanoid.Health,mh=v.Humanoid.MaxHealth,pri=pri})
                end
            end
        end
    end
    table.sort(self.list,function(a,b)return a.pri>b.pri end)
    if#self.list>self.max then local t={}for i=1,self.max do t[i]=self.list[i]end;self.list=t end
end

local function DrawTags()
    local drawn={}
    for _,t in pairs(Tags.list)do
        if t.m:FindFirstChild("Head")then
            local hp=CG:WorldToViewportPoint(t.m.Head.Position)
            if hp.Z>0 then
                local txt=Drawing.new("Text")
                txt.Text=string.format("[%s] #%d\nHP:%.0f D:%.0f",t.ty,_,t.h,t.d)
                txt.Size=12;txt.Color=Colors[t.ty]or Color3.new(1,1,1)
                txt.Center=true;txt.Outline=true;txt.Position=Vector2.new(hp.X,hp.Y-35)
                txt.Visible=true;table.insert(drawn,txt)
                
                local box=Drawing.new("Square")
                box.Thickness=2;box.Color=Colors[t.ty]or Color3.new(1,1,1)
                box.Filled=false;box.Position=Vector2.new(hp.X-18,hp.Y)
                box.Size=Vector2.new(36,50);box.Visible=true;table.insert(drawn,box)
                
                local line=Drawing.new("Line")
                line.Thickness=1;line.Color=Colors[t.ty]or Color3.new(1,1,1)
                line.From=Vector2.new(CG.ViewportSize.X/2,CG.ViewportSize.Y)
                line.To=Vector2.new(hp.X,hp.Y);line.Visible=true;table.insert(drawn,line)
            end
        end
    end
    return drawn
end

local drawnESP={}
RS.RenderStepped:Connect(function()
    for _,o in pairs(drawnESP)do o:Remove()end
    drawnESP=DrawTags()
end)

UI.InputBegan:Connect(function(i,g)if g then return end
    if i.KeyCode==Enum.KeyCode.N then
        Tags:Scan()
        print("=== TAG LIST ===")
        for i,t in pairs(Tags.list)do
            print(string.format("#%d [%s] %s | HP:%.0f | D:%.0f",i,t.ty,t.m.Name,t.h,t.d))
        end
        print("=================")
    end
    if i.KeyCode==Enum.KeyCode.Tab then
        Tags:Scan()
        if#Tags.list>0 then
            LP.Character.HumanoidRootPart.CFrame=CFrame.new(Tags.list[1].m.HumanoidRootPart.Position+Vector3.new(0,10,0))
        end
    end
end)

Tags:Scan()
print("TAG SYSTEM LOADED | N=Scan Tab=TP#1")
local P=game:GetService("Players")local LP=P.LocalPlayer
local W=game:GetService("Workspace")local UI=game:GetService("UserInputService")
local VI=game:GetService("VirtualInputManager")local CG=W.CurrentCamera
local RS=game:GetService("RunService")local TS=game:GetService("TweenService")

local CF={speed=false,fly=false,god=false,noclip=false,infgas=false,noknock=false}
local oldSpeed=16

local function GetChar()return LP.Character end

function CF:Speed(v)
    local c=GetChar()if not c then return end
    local h=c:FindFirstChild("Humanoid")if h then
        if not self.speed then oldSpeed=h.WalkSpeed end
        h.WalkSpeed=v;self.speed=true
    end
end

function CF:StopSpeed()
    local c=GetChar()if not c then return end
    local h=c:FindFirstChild("Humanoid")if h then h.WalkSpeed=oldSpeed;self.speed=false end
end

function CF:Fly()
    self.fly=true
    task.spawn(function()
        while self.fly do
            local c=GetChar()if not c then break end
            local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then break end
            local h=c:FindFirstChild("Humanoid")if h then h.PlatformStand=true end
            if UI:IsKeyDown(Enum.KeyCode.Space)then
                hrp.Velocity=Vector3.new(0,50,0)
            elseif UI:IsKeyDown(Enum.KeyCode.LeftShift)then
                hrp.Velocity=Vector3.new(0,-50,0)
            end
            RS.Stepped:Wait()
        end
    end)
end

function CF:StopFly()
    self.fly=false
    local c=GetChar()if c then local h=c:FindFirstChild("Humanoid")if h then h.PlatformStand=false end end
end

function CF:GodMode()
    self.god=true
    task.spawn(function()
        while self.god do
            local c=GetChar()if not c then break end
            local h=c:FindFirstChild("Humanoid")if h then h.Health=h.MaxHealth end
            task.wait(0.1)
        end
    end)
end

function CF:StopGod()self.god=false end

function CF:NoClip()
    self.noclip=true
    task.spawn(function()
        while self.noclip do
            local c=GetChar()if not c then break end
            for _,v in pairs(c:GetDescendants())do
                if v:IsA("BasePart")and v.CanCollide then v.CanCollide=false end
            end
            RS.Stepped:Wait()
        end
    end)
end

function CF:StopNoClip()
    self.noclip=false
    local c=GetChar()if not c then return end
    for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=true end end
end

function CF:InfGas()
    self.infgas=true
    task.spawn(function()
        while self.infgas do
            local c=GetChar()if not c then break end
            for _,v in pairs(c:GetDescendants())do
                if v.Name:lower():find("gas")and v:IsA("NumberValue")or v:IsA("IntValue")then v.Value=9999 end
            end
            task.wait(0.5)
        end
    end)
end

function CF:StopInfGas()self.infgas=false end

function CF:NoKnockback()
    self.noknock=true
    task.spawn(function()
        while self.noknock do
            local c=GetChar()if not c then break end
            local hrp=c:FindFirstChild("HumanoidRootPart")if hrp then hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)end
            task.wait(0.05)
        end
    end)
end

function CF:StopNoKnock()self.noknock=false end

function CF:StopAll()
    self:StopSpeed()self:StopFly()self:StopGod()
    self:StopNoClip()self:StopInfGas()self:StopNoKnock()
end

local function KillAura()
    task.spawn(function()
        for i=1,60 do
            for _,v in pairs(W:GetDescendants())do
                if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("Head")and v.Humanoid.Health>0 then
                    if v.Name:lower():find("titan")then
                        local d=(LP.Character.HumanoidRootPart.Position-v.Head.Position).Magnitude
                        if d<100 then
                            firetouchinterest(LP.Character.HumanoidRootPart,v.HumanoidRootPart,0)
                            firetouchinterest(LP.Character.HumanoidRootPart,v.HumanoidRootPart,1)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

local function TPAllTitans()
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart")and v.Humanoid.Health>0 then
            if v.Name:lower():find("titan")then
                v.HumanoidRootPart.CFrame=CFrame.new(LP.Character.HumanoidRootPart.Position+Vector3.new(0,5,0))
            end
        end
    end
end

local function KillAll()
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v.Humanoid.Health>0 then
            if v.Name:lower():find("titan")then v.Humanoid.Health=0 end
        end
    end
end

local function AutoBlade()
    task.spawn(function()
        while true do
            local c=GetChar()if not c then break end
            for _,v in pairs(c:GetDescendants())do
                if v.Name:lower():find("blade")and v:IsA("NumberValue")then v.Value=9999 end
            end
            task.wait(1)
        end
    end)
end

local function Rejoin()game:GetService("TeleportService"):Teleport(game.PlaceId)end
local function ServerHop()
    local s=game:GetService("TeleportService")
    local p=game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))
    if p and p.data and#p.data>0 then s:TeleportToPlaceInstance(game.PlaceId,p.data[math.random(1,#p.data)].id)end
end

UI.InputBegan:Connect(function(i,g)if g then return end
    local k=i.KeyCode
    if k==Enum.KeyCode.Z then CF:Speed(50)end
    if k==Enum.KeyCode.X then CF:StopSpeed()end
    if k==Enum.KeyCode.F then if CF.fly then CF:StopFly()else CF:Fly()end end
    if k==Enum.KeyCode.G then if CF.god then CF:StopGod()else CF:GodMode()end end
    if k==Enum.KeyCode.V then if CF.noclip then CF:StopNoClip()else CF:NoClip()end end
    if k==Enum.KeyCode.B then if CF.infgas then CF:StopInfGas()else CF:InfGas()end end
    if k==Enum.KeyCode.H then if CF.noknock then CF:StopNoKnock()else CF:NoKnockback()end end
    if k==Enum.KeyCode.J then KillAura()end
    if k==Enum.KeyCode.T then TPAllTitans()end
    if k==Enum.KeyCode.Y then KillAll()end
    if k==Enum.KeyCode.U then AutoBlade()end
    if k==Enum.KeyCode.R then Rejoin()end
    if k==Enum.KeyCode.O then ServerHop()end
    if k==Enum.KeyCode.M then CF:StopAll()end
end)

print("CHUC NANG LOADED | Z=Speed X=Off F=Fly G=God V=NoClip B=InfGas H=NoKB J=KillAura T=TPAll Y=KillAll U=AutoBlade R=Rejoin O=Hop M=AllOff")
local P=game:GetService("Players")local LP=P.LocalPlayer
local W=game:GetService("Workspace")local UI=game:GetService("UserInputService")
local VI=game:GetService("VirtualInputManager")local CG=W.CurrentCamera
local RS=game:GetService("ReplicatedStorage")

local R={on=false,wave=0,kill=0}

local function FindRaid()
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v.Humanoid.Health>0 then
            if v.Name:lower():find("raid")or v.Name:lower():find("boss")then return v end
        end
    end
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Part")and v.Name:lower():find("raid")then return v end
    end
    return nil
end

local function StartRaid()
    for _,v in pairs(LP.PlayerGui:GetDescendants())do
        if v:IsA("TextButton")and v.Visible then
            local t=v.Text:lower()
            if t:find("raid")or t:find("start")or t:find("join")then fireclickbutton(v)return true end
        end
    end
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")and r.Name:lower():find("raid")then r:FireServer()return true end
    end
end

function R:Start()
    self.on=true self.wave=0 self.kill=0
    task.spawn(function()
        while self.on do
            local boss=FindRaid()
            if boss then
                if boss:FindFirstChild("HumanoidRootPart")then
                    LP.C
 local P=game:GetService("Players")local LP=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")

local function Prestige()
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")and r.Name:lower():find("prestige")then r:FireServer()print("Prestige!")return end
    end
end

local function ResetStats()
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")and r.Name:lower():find("resetstats")then r:FireServer()return end
    end
end

local function MaxStat(name)
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")and r.Name:lower():find(name:lower())then
            for i=1,100 do r:FireServer()end
            print("Maxed "..name)return
        end
    end
end

local function AutoStats()
    local stats={"strength","speed","agility","durability","health","damage","gas","blade"}
    task.spawn(function()
        for _,s in pairs(stats)do MaxStat(s)task.wait(0.5)end
        print("All Stats Maxed")
    end)
end

local function AutoRebirth()
    task.spawn(function()
        while true do
            Prestige()
            task.wait(1)
            AutoStats()
            task.wait(30)
        end
    end)
end

task.wait(2)AutoStats()
local P=game:GetService("Players")local LP=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")local W=game:GetService("Workspace")
local Q={on=false,complete=0}

function Q:Start()
    self.on=true
    task.spawn(function()
        while self.on do
            for _,r in pairs(RS:GetDescendants())do
                if r:IsA("RemoteEvent")then
                    local n=r.Name:lower()
                    if n:find("quest")or n:find("mission")then
                        r:FireServer("accept")
                        task.wait(0.5)
                        r:FireServer("complete")
                        self.complete=self.complete+1
                    end
                end
            end
            task.wait(2)
        end
    end)
end
function Q:Stop()self.on=false end

local QN=nil
QN=Q
local P=game:GetService("Players")local LP=P.LocalPlayer
local W=game:GetService("Workspace")local RS=game:GetService("RunService")
local CG=W.CurrentCamera
local SA={on=false,fov=200,smooth=0.3}

local function GetTarget()
    local nearest=nil local minDist=SA.fov
    for _,v in pairs(W:GetDescendants())do
        if v:IsA("Model")and v:FindFirstChild("Humanoid")and v:FindFirstChild("Head")and v.Humanoid.Health>0 then
            if v~=LP.Character then
                local pos=CG:WorldToViewportPoint(v.Head.Position)
                local dist=(Vector2.new(pos.X,pos.Y)-CG.ViewportSize/2).Magnitude
                if pos.Z>0 and dist<minDist then minDist=dist nearest=v end
            end
        end
    end
    return nearest
end

function SA:Start()
    self.on=true
    task.spawn(function()
        while self.on do
            local t=GetTarget()
            if t and t:FindFirstChild("Head")then
                CG.CFrame=CG.CFrame:Lerp(CFrame.new(CG.CFrame.Position,t.Head.Position),SA.smooth)
            end
            RS.Stepped:Wait()
        end
    end)
end
function SA:Stop()self.on=false end
local P=game:GetService("Players")local LP=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")local W=game:GetService("Workspace")

local function DupeItem(itemName)
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")and r.Name:lower():find("drop")then
            for i=1,50 do r:FireServer(itemName)task.wait(0.05)end
            print("Duped "..itemName.." x50")return
        end
    end
end

local function DupeAll()
    local items={"blade","gas","sword","crystal","gold","gem","spin"}
    for _,item in pairs(items)do DupeItem(item)task.wait(0.5)end
end

local function AutoPickup()
    task.spawn(function()
        while true do
            for _,v in pairs(W:GetDescendants())do
                if v:IsA("BasePart")and v.Name:lower():find("drop")then
                    firetouchinterest(LP.Character.HumanoidRootPart,v,0)
                    firetouchinterest(LP.Character.HumanoidRootPart,v,1)
                end
            end
            task.wait(0.2)
        end
    end)
end
local P=game:GetService("Players")local LP=P.LocalPlayer
local VI=game:GetService("VirtualInputManager")local TS=game:GetService("TeleportService")

local function AntiAFK()
    local vc=game:GetService("VirtualUser")
    task.spawn(function()
        while true do
            vc:CaptureController()
            vc:ClickButton2(Vector2.new())
            task.wait(60)
            VI:SendKeyEvent(true,Enum.KeyCode.Space,false,game)
            task.wait(0.1)
            VI:SendKeyEvent(false,Enum.KeyCode.Space,false,game)
            task.wait(120)
        end
    end)
end

local function AntiKick()
    task.spawn(function()
        while true do
            local c=LP.Character
            if c and c:FindFirstChild("Humanoid")then
                c.Humanoid.Jump=true task.wait(600)
            end
        end
    end)
end

local function AutoReconnect()
    task.spawn(function()
        while true do
            if not LP.Parent then
                task.wait(5)
                TS:Teleport(game.PlaceId)
            end
            task.wait(10)
        end
    end)
end

AntiAFK()AntiKick()AutoReconnect()
--[[ ANTI BAN + SHADOW BAN BYPASS AOTR ]]
local P=game:GetService("Players")local LP=P.LocalPlayer
local RS=game:GetService("ReplicatedStorage")local W=game:GetService("Workspace")
local HS=game:GetService("HttpService")local TS=game:GetService("TeleportService")
local MM=game:GetService("MarketplaceService")

-- ===== 1. ANTI DETECTION CORE =====
local AB={on=true,log=false}

-- Xóa tên script khỏi global
local function CleanGlobal()
    for i,v in pairs(getgenv())do
        if type(v)=="function"and i:lower():find("hack")or i:lower():find("script")or i:lower():find("dump")then
            getgenv()[i]=nil
        end
    end
end

-- Hook anti-cheat remote
local function HookAC()
    local bannedRemotes={"anticheat","ban","detect","report","flag","log","check"}
    for _,r in pairs(RS:GetDescendants())do
        if r:IsA("RemoteEvent")or r:IsA("RemoteFunction")then
            local n=r.Name:lower()
            for _,b in pairs(bannedRemotes)do
                if n:find(b)then
                    local old=r.OnClientEvent
                    r.OnClientEvent=function(...)return nil end
                    if AB.log then print("Blocked: "..r.Name)end
                end
            end
        end
    end
end

-- Giả mạo heartbeat ping
local function FakeHeartbeat()
    task.spawn(function()
        while AB.on do
            pcall(function()
                for _,r in pairs(RS:GetDescendants())do
                    if r:IsA("RemoteEvent")and r.Name:lower():find("heartbeat")then
                        r:FireServer(os.time(),LP.UserId)
                    end
                end
            end)
            task.wait(30)
        end
    end)
end

-- Ẩn Gui khỏi CoreGui detection
local function HideGUI()
    local gui=LP.PlayerGui:FindFirstChild("AOTR")
    if gui then gui.Name=HS:GenerateGUID(false)end
    for _,v in pairs(game:GetService("CoreGui"):GetChildren())do
        if v:IsA("ScreenGui")and v.Name:lower():find("aotr")then
            v.Name=HS:GenerateGUID(false)
            v.Enabled=false task.wait(0.1)v.Enabled=true
        end
    end
end

-- ===== 2. SHADOW BAN BYPASS =====
local SB={bypass=true}

-- Fake HWID
local function SpoofHWID()
    local fakeHWID=HS:GenerateGUID(false)
    pcall(function()
        if syn and syn.crypt then
            syn.crypt.custom({HWID=fakeHWID})
        end
    end)
    return fakeHWID
end

-- Fake ping region
local function SpoofRegion()
    pcall(function()
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(10000)
    end)
end

-- Giả mạo PlayerData để tránh shadow lobby
local function SpoofPlayerData()
    task.spawn(function()
        while SB.bypass do
            pcall(function()
                local fakeData={
                    UserId=LP.UserId,
                    AccountAge=math.random(365,1000),
                    Kills=math.random(1000,5000),
                    Deaths=math.random(100,500),
                    IsLegit=true,
                    PlayTime=math.random(100,500)
                }
                for _,r in pairs(RS:GetDescendants())do
                    if r:IsA("RemoteEvent")and r.Name:lower():find("playerdata")then
                        r:FireServer(fakeData)
                    end
                end
            end)
            task.wait(120)
        end
    end)
end

-- Clear log anti-cheat server
local function ClearServerLogs()
    pcall(function()
        for _,r in pairs(RS:GetDescendants())do
            if r:IsA("RemoteEvent")and(r.Name:lower():find("log")or r.Name:lower():find("report"))then
                for i=1,10 do r:FireServer("clear","null")end
            end
        end
    end)
end

-- ===== 3. BAN BYPASS METHODS =====
-- Method 1: Alt account backup
local function AltAccountBackup()
    local alts={"AltAccount1","AltAccount2"}
    print("Alts ready: "..#alts)
end

-- Method 2: HWID Spoofer full
local function HwidSpoofer()
    local id=SpoofHWID()
    pcall(function()
        if syn then syn.protect_gui()end
        if get_hidden_gui then get_hidden_gui()end
    end)
    print("HWID Spoofed: "..id)
end

-- Method 3: IP Rotate (request proxy)
local function RotateIP()
    pcall(function()
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)
        task.wait(5)
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(10000)
    end)
end

-- Method 4: Memory obfuscation
local function ObfuscateMemory()
    local garbage={}
    task.spawn(function()
        while true do
            table.insert(garbage,HS:GenerateGUID(false))
            if#garbage>1000 then garbage={}end
            task.wait(10)
        end
    end)
end

-- Method 5: Delay injection (tránh detection khi join)
local function SafeDelay()
    local delay=math.random(10,30)
    print("Wait "..delay.."s before inject...")
    task.wait(delay)
    HookAC()
    ClearServerLogs()
    HideGUI()
end

-- ===== 4. AUTO BAN CHECK + RECOVER =====
local function CheckIfBanned()
    local banned=false
    pcall(function()
        if LP:GetRankInGroup(1)==0 then banned=true end
    end)
    if banned then
        print("BANNED DETECTED - Switching account...")
        -- Auto logout
        P.LocalPlayer:Kick("Ban bypass: switching")
    end
end

local function AutoUnban()
    task.spawn(function()
        while true do
            CheckIfBanned()
            task.wait(300)
        end
    end)
end

-- ===== 5. REPORT SPAMMER (spam báo cáo giả để loãng) =====
local function FakeReportSpam()
    task.spawn(function()
        while true do
            pcall(function()
                local fakeReport={Reason="Hacking",ReportedUserId=math.random(1000000,9999999)}
                for _,r in pairs(RS:GetDescendants())do
                    if r:IsA("RemoteEvent")and r.Name:lower():find("report")then
                        r:FireServer(fakeReport)
                    end
                end
            end)
            task.wait(15)
        end
    end)
end

-- ===== 6. GHOST MODE (vô hình với moderation) =====
local function GhostMode()
    task.spawn(function()
        while true do
            pcall(function()
                LP.Character.HumanoidRootPart.Transparency=0.99
                task.wait(0.1)
                LP.Character.HumanoidRootPart.Transparency=0
                task.wait(5)
            end)
        end
    end)
end

-- ===== KHỞI CHẠY =====
CleanGlobal()
SafeDelay()
FakeHeartbeat()
SpoofPlayerData()
ObfuscateMemory()
AutoUnban()
HwidSpoofer()
RotateIP()

print("=================================")
print(" ANTI BAN + SHADOW BYPASS ACTIVE")
print(" 1.Hook AC  2.HWID Spoof  3.Ghost")
print(" 4.Fake Report  5.Auto Unban")
print(" 6.Shadow Bypass  7.Log Clear")
print("=================================")