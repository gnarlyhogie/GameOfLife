debug = false;

function love.load()
	img_fn = {"ship"}
	img = love.graphics.newImage("assets/ship.png")
	for _, v in ipairs(img_fn) do
		--img[v] = love.graphics.newImage("assets/"..v..".png")
	end

	x_offset = love.graphics.getWidth()/17
	y_offset = love.graphics.getHeight()/17

	width = 0
	height = 0

	love.keyboard.setKeyRepeat(enable)
	mousePressed = "false"
	state = "idle"

	grid = {}
	for i = -1, 18 do
		grid[i] = {}
		for j = -1, 18 do
			grid[i][j] = 0
		end
	end
	next_grid = {}
	for i = -1, 18 do
		next_grid[i] = {}
		for j = -1, 18 do
			next_grid[i][j] = 0
		end
	end
end

function love.update(dt)
	status = 0
	if state == "play" then
		for i = 0, 17 do
			for j = 0, 17 do
				next_grid[i][j]=grid[i][j]
				if grid[i][j] == 1 then
					if grid[i-1][j] == 1 then
						status= status + 1
					end
					if grid[i][j-1] == 1 then
						status = status + 1
					end
					if grid[i+1][j] == 1 then
						status = status + 1
					end
					if grid[i][j+1] == 1 then
						status = status + 1
					end
					if grid[i-1][j-1] == 1 then
						status= status + 1
					end
					if grid[i+1][j-1] == 1 then
						status = status + 1
					end
					if grid[i+1][j+1] == 1 then
						status = status + 1
					end
					if grid[i-1][j+1] == 1 then
						status = status + 1
					end
					if status < 2 then
						next_grid[i][j] = 0
					end
					if status >= 4 then
						next_grid[i][j] = 0
					end
				end
				if grid[i][j] == 0 then
					if grid[i-1][j] == 1 then
						status= status + 1
					end
					if grid[i][j-1] == 1 then
						status = status + 1
					end
					if grid[i+1][j] == 1 then
						status = status + 1
					end
					if grid[i][j+1] == 1 then
						status = status + 1
					end
					if grid[i-1][j-1] == 1 then
						status= status + 1
					end
					if grid[i+1][j-1] == 1 then
						status = status + 1
					end
					if grid[i+1][j+1] == 1 then
						status = status + 1
					end
					if grid[i-1][j+1] == 1 then
						status = status + 1
					end
					if status == 3 then
						next_grid[i][j] = 1
					end
				end
				status = 0
			end
		end
		for i = -1, 18 do
			for j = -1, 18 do
				grid[i][j] = next_grid[i][j]
			end
		end
		state = "idle"
	end
end


function love.keyreleased(key)
    if key == "left" then
		hero.x = hero.x - hero.speed   
	end
	if key == "right" then
		hero.x = hero.x + hero.speed
	end
	if key == "up" then
		hero.y = hero.y + hero.speed
	end
	if key == "down" then
		hero.y = hero.y - hero.speed
	end
	if key == "p" then
		if state == "idle" then
			state = "play"
			print("play")
		else 
			state = "idle"
			print("idle")
		end
	end
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		mousePressed = "true"
		width = x - (x % x_offset)
		height = y - (y % y_offset)
		f = 0
		d = 0
		while f <= width/(love.graphics.getWidth()/17) - 1 do
			f = f + 1
		end
		print(f)
		while d <= height/(love.graphics.getHeight()/17) - 1 do
			d = d + 1
		end
		print(d)
		if grid[f][d] == 1 then
			grid[f][d]=0
		else
			grid[f][d]=1
		end
	end
end


function love.draw()
	h = 0
	w = 0
	while h < love.graphics.getHeight() do
		h = h + (love.graphics.getHeight()/17)
    	love.graphics.line(w, h, love.graphics.getWidth(), h)
    end
    h = 0
    while w < love.graphics.getWidth() do
    	w = w + love.graphics.getWidth()/17
    	love.graphics.line(w, h, w, love.graphics.getHeight())
    end
    for i = 0, 17 do
    	for j = 0, 17 do
    		if grid[i][j] == 1 then
    			love.graphics.setColor(255, 100, 200) 
    			love.graphics.rectangle("fill", i*(love.graphics.getWidth()/17), j*(love.graphics.getHeight()/17), love.graphics.getWidth()/17, love.graphics.getHeight()/17)
    		end
    	end
    end
end	