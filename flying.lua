local player = {
       x = 0,
       y = 5,
       z = 0,
       speed = 10,
       flying = false
}

function toggleFly()
         player.flying = not
player.flying
end

function update()
     if  player.flying then
         if player.upPressed then
                    player.y = player.y +
player.speed
        end
         if player.downPressed then
                    player.y = player.y -
player.speed
        end
         if player.forwardPressed then
                    player.z = player.z -
player.speed
        end
         if player.backPressed then
                    player.z = player.z +
player.speed
        end
         if player.leftPressed then
                    player.x = player.x -
player.speed
        end
         if player.rightPressed then
                    player.x = player.x +
player.speed
        end
    else
--gaviti
    player.y = player.y - 3
   end
end