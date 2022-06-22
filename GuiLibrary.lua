
local m = {}
function m:Ui(name)
	local UIPARENT = game.CoreGui
	if game:GetService("RunService"):IsStudio() then
		UIPARENT =game.Players.LocalPlayer.PlayerGui
	end
	local f = Instance.new("ScreenGui",UIPARENT)
	f.Name = name
	local modal = Instance.new('TextButton',f)
	modal.Size = UDim2.new(0,0,0,0)
	modal.Text = ''
	modal.TextTransparency = 1
	local screen = {}
	local n = {}
	local FramesCreated = -1
	local plr = game.Players.LocalPlayer

	function n:Visibility(bool)
		if bool ~= nil then
			f.Enabled = bool
		else
			return f.Enabled
		end
	end

	function n:lPlayer()
		return plr
	end

	function n:MouseState(bool)
		modal.Modal = bool
	end

	function n:newTabs(name,color,textfont)
		name = name or "TitleText"
		color = color or nil
		textfont = textfont or Enum.Font.Gotham
		local Text_Color_Opposite
		local Frame_Color_Opposite
		local Button_Color_Opposite
		local textsize = 13
		local padding1 = 34
		local padding2 = 104
		local padding3 = 52
		local screenincre =0
		local bigOverlay = false
		if color ~= nil then
			if typeof(color) == "Color3" then
				Text_Color_Opposite = {color:ToHSV()}
				Text_Color_Opposite = Text_Color_Opposite[3]*255
				if Text_Color_Opposite < 90 then
					Text_Color_Opposite = Color3.new(1, 1, 1)
					Frame_Color_Opposite = Color3.fromRGB(221, 221, 221)
					Button_Color_Opposite = Color3.fromRGB(228,228,228)
				else
					Text_Color_Opposite = Color3.new(0, 0, 0)
					Frame_Color_Opposite = Color3.fromRGB(0, 0, 0)
					Button_Color_Opposite = Color3.fromRGB(27,27,27)
				end
			end
		else
			Text_Color_Opposite = Color3.new(0, 0, 0)
			Frame_Color_Opposite = Color3.fromRGB(0, 0, 0)
			Button_Color_Opposite = Color3.fromRGB(27,27,27)
			color = Color3.new(1, 1, 1)
		end
		FramesCreated = FramesCreated + 1
		if FramesCreated == 7 then
			FramesCreated = -1
			FramesCreated = FramesCreated + 1
		end
		local a = {
			Tab = Instance.new("Frame",f),
			TabTitle = Instance.new("TextLabel"),
			TabView = Instance.new("ScrollingFrame"),
			ViewerLayout = Instance.new("UIListLayout"),
			TabCorner = Instance.new("UICorner"),
			TabLayout = Instance.new("UIListLayout")
		}
		--stolen from someone plugin on rblxst lol didnt want to use .draggable XD
		local UserInputService = game:GetService("UserInputService")
		local gui = a.TabTitle
		local movinggui = a.Tab
		local dragging
		local dragInput
		local dragStart
		local startPos
		local function update(input)
			local delta = input.Position - dragStart
			wait(.01)
			movinggui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
		gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = movinggui.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)


		a.Tab.Name = name
		a.Tab.BackgroundColor3 = color
		a.Tab.Position = UDim2.new(0.424366295, 0, 0.396978021, 0)
		a.Tab.Size = UDim2.new(0, 150, 0, 180)

		a.TabTitle.Parent = a.Tab
		a.TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		a.TabTitle.BackgroundTransparency = 1
		a.TabTitle.Size = UDim2.new(1, 0, 0.14, 0)
		a.TabTitle.Font = textfont
		a.TabTitle.Text = name
		a.TabTitle.TextColor3 = Text_Color_Opposite
		a.TabTitle.TextSize = textsize
		a.TabTitle.TextWrapped = true

		a.TabView.Parent = a.Tab
		a.TabView.Active = true
		a.TabView.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		a.TabView.BackgroundTransparency = 1
		a.TabView.Size = UDim2.new(1, 0, 0.855, 0)
		a.TabView.CanvasSize = UDim2.new(0, 0, 0, 0)
		a.TabView.ScrollBarThickness = 6
		a.TabView.LayoutOrder = 1
		a.TabView.AutomaticCanvasSize = Enum.AutomaticSize.Y
		a.TabView.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

		a.ViewerLayout.Parent = a.TabView
		a.ViewerLayout.SortOrder = Enum.SortOrder.LayoutOrder
		a.ViewerLayout.Padding = UDim.new(0, 1)

		a.TabCorner.CornerRadius = UDim.new(0, 4)
		a.TabCorner.Parent = a.Tab

		a.TabLayout.Parent = a.Tab
		a.TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		a.TabLayout.Padding = UDim.new(0, 1)

		table.insert(screen,a.Tab)
		if #screen > 7 then
			screenincre = #screen - 7
			a.Tab.Position = UDim2.new(0, 50+(210*FramesCreated),0, 5+(screen[screenincre].AbsoluteSize.Y+screen[screenincre].AbsolutePosition.Y))
		else
			a.Tab.Position = UDim2.new(0, 50+(210*FramesCreated),0, 50)
		end
		local tab = {}

		function tab:AddPage(PageTitle)
			local x = {
				PageToggle = Instance.new("TextButton"),
				Page = Instance.new("Frame",f),
				PageCorner = Instance.new("UICorner"),
				PageLayout = Instance.new("UIListLayout"),
				PageName = Instance.new("TextLabel"),
				PageView = Instance.new("ScrollingFrame"),
				ViewLayout = Instance.new("UIListLayout")
			}
			local UserInputService = game:GetService("UserInputService")
			local gui = x.PageName
			local movinggui = x.Page
			local dragging
			local dragInput
			local dragStart
			local startPos
			local function update(input)
				local delta = input.Position - dragStart
				wait(.01)
				movinggui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = movinggui.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)
			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)

			x.PageToggle.Parent = a.TabView
			x.PageToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageToggle.BackgroundTransparency = 1
			x.PageToggle.BorderSizePixel = 0
			x.PageToggle.Size = UDim2.new(1, 0, 0, 30)
			x.PageToggle.Font = textfont
			x.PageToggle.Text = PageTitle
			x.PageToggle.TextColor3 = Text_Color_Opposite
			x.PageToggle.TextSize = textsize
			x.PageToggle.TextWrapped = true
			x.Page.Visible = not x.Page.Visible
			x.PageToggle.MouseButton1Click:Connect(function()
				x.Page.Visible = not x.Page.Visible
			end)
			x.PageToggle.MouseButton2Click:Connect(function()
				x.Page:TweenPosition(UDim2.new(0,a.Tab.Position.X.Offset + a.Tab.Size.X.Offset + 25,0,a.Tab.Position.Y.Offset),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
			end)

			x.Page.BackgroundColor3 = color
			x.Page:TweenPosition(UDim2.new(0,a.Tab.Position.X.Offset + a.Tab.Size.X.Offset + 25,0,a.Tab.Position.Y.Offset),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
			x.Page.Size = UDim2.new(0, 150, 0, 180)

			x.PageCorner.CornerRadius = UDim.new(0, 4)
			x.PageCorner.Parent = x.Page

			x.PageLayout.Parent = x.Page
			x.PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
			x.PageLayout.Padding = UDim.new(0, 1)

			x.PageName.Name = PageTitle
			x.PageName.Parent = x.Page
			x.PageName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageName.BackgroundTransparency = 1
			x.PageName.Size = UDim2.new(1, 0, 0, 25.2)
			x.PageName.Font = textfont
			x.PageName.Text = PageTitle
			x.PageName.TextColor3 = Text_Color_Opposite
			x.PageName.TextSize = textsize
			x.PageName.TextWrapped = true
			x.PageName.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton2 then
					if x.PageView.Visible then
						x.Page:TweenSize(UDim2.new(0, 150, 0, 180*.14),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
						x.PageView:TweenSize(UDim2.new(1, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
						x.PageView.Visible = not x.PageView.Visible
					else
						x.Page:TweenSize(UDim2.new(0, 150, 0, 180),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
						x.PageView:TweenSize(UDim2.new(1, 0, 0.855, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
						x.PageView.Visible = not x.PageView.Visible
					end
				end
			end)

			x.PageView.Parent = x.Page
			x.PageView.Active = true
			x.PageView.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageView.BackgroundTransparency = 1
			x.PageView.LayoutOrder = 1
			x.PageView.Size = UDim2.new(1, 0, 0.855, 0)
			x.PageView.CanvasSize = UDim2.new(0, 0, 0, 0)
			x.PageView.ScrollBarThickness = 6
			x.PageView.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			x.PageView.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
			x.Page:TweenSize(UDim2.new(0, 150, 0, 180*.14),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
			x.PageView:TweenSize(UDim2.new(1, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.1)
			x.PageView.Visible = not x.PageView.Visible
			x.PageView.AutomaticCanvasSize = 'Y'

			x.ViewLayout.Parent = x.PageView
			x.ViewLayout.SortOrder = Enum.SortOrder.LayoutOrder
			x.ViewLayout.Padding = UDim.new(0, 1)

			local page = {}

			function page:Button(Text,OnClick)
				local b = {
					Button = Instance.new("TextButton"),
					ButtonCorner = Instance.new("UICorner")
				}
				OnClick = OnClick or function() end
				Text = Text or 'Button'
				b.Button.Parent = x.PageView
				b.Button.BackgroundColor3 = Frame_Color_Opposite
				b.Button.BackgroundTransparency = 0.950
				b.Button.BorderSizePixel = 0
				b.Button.Size = UDim2.new(1, 0, 0, 30)
				b.Button.Font = textfont
				b.Button.TextColor3 = Text_Color_Opposite
				b.Button.TextSize = textsize
				b.Button.Text = Text
				b.Button.TextWrapped = true

				b.ButtonCorner.CornerRadius = UDim.new(0, 4)
				b.ButtonCorner.Parent = b.Button

				local ClickFunction = b.Button.MouseButton1Click:Connect(function()
					OnClick()
				end)

				local e = {}

				function e:newOnClick(func)
					ClickFunction:Disconnect()
					ClickFunction = b.Button.MouseButton1Click:Connect(function()
						func()
					end)
				end				
				function e:newText(Text)
					b.Button.Text = Text
				end			
				function e:Self()
					return b.Button
				end

				return e
			end
			function page:ToggleBind(Text,State,Key,OnPressed)
				local b = {
					ToggleButton = Instance.new("ImageButton"),
					ToggleButtonLayout = Instance.new("UIListLayout"),
					DisplayEnumKey = Instance.new("TextLabel"),
					DisplayEnumKeyCorner = Instance.new("UICorner"),
					ToggleButtonText = Instance.new("TextLabel")
				}
				Text = Text or "ToggleBind"
				State = State or false
				Key = Key or Enum.KeyCode.F
				OnPressed = OnPressed or function() end
				if typeof(Key) == 'string' then
					if Enum.KeyCode[string.upper(Key)] == nil then
						Key = Enum.KeyCode.F
					else
						Key = Enum.KeyCode[string.upper(Key)]
					end
				end

				b.ToggleButton.Parent = x.PageView
				b.ToggleButton.BackgroundColor3 = Frame_Color_Opposite
				b.ToggleButton.BackgroundTransparency = .95
				b.ToggleButton.BorderSizePixel = 0
				b.ToggleButton.Size = UDim2.new(1, 0, 0, 30)
				b.ToggleButton.ImageTransparency = 1

				b.ToggleButtonLayout.Parent = b.ToggleButton
				b.ToggleButtonLayout.FillDirection = Enum.FillDirection.Horizontal
				b.ToggleButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

				b.DisplayEnumKey.Parent = b.ToggleButton
				b.DisplayEnumKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.DisplayEnumKey.BackgroundTransparency = 1
				b.DisplayEnumKey.LayoutOrder = 1
				b.DisplayEnumKey.Position = UDim2.new(0.573333323, 0, 0, 0)
				b.DisplayEnumKey.Size = UDim2.new(0.206, 0, 1, 0)
				b.DisplayEnumKey.Font = textfont
				b.DisplayEnumKey.Text = Key.Name
				b.DisplayEnumKey.LayoutOrder = 1
				b.DisplayEnumKey.TextColor3 = Text_Color_Opposite
				b.DisplayEnumKey.TextSize = textsize
				b.DisplayEnumKey.TextWrapped = true

				b.DisplayEnumKeyCorner.CornerRadius = UDim.new(0, 4)
				b.DisplayEnumKeyCorner.Parent = b.DisplayEnumKey

				b.ToggleButtonText.Parent = b.ToggleButton
				b.ToggleButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.ToggleButtonText.BackgroundTransparency = 1
				b.ToggleButtonText.Size = UDim2.new(0.8, 0, 1, 0)
				b.ToggleButtonText.Font = textfont
				b.ToggleButtonText.Text = Text
				b.ToggleButtonText.TextColor3 = Text_Color_Opposite
				b.ToggleButtonText.TextSize = textsize
				b.ToggleButtonText.TextWrapped = true
				local function Color(x)
					if x then
						b.ToggleButton.BackgroundColor3 = Color3.new(0.0156863, 0.737255, 0.8)
						b.ToggleButton.BackgroundTransparency = .85
					else
						b.ToggleButton.BackgroundColor3 = Frame_Color_Opposite
						b.ToggleButton.BackgroundTransparency = .95
					end
				end
				Color(State)
				local binding = game:GetService("UserInputService").InputEnded:Connect(function(inp,gp)
					if inp.KeyCode == Key then
						local ji = false
						local function z()
							if ji == false  then
								ji = true
								OnPressed(State,gp)
								wait()
								ji = false
							end
						end z()
					end
				end)
				local KC = false

				b.ToggleButton.MouseButton1Click:Connect(function()
					State = not State
					Color(State)
				end)
				b.ToggleButton.MouseButton2Click:Connect(function()
					if not KC then
						KC = true
						local yes;yes = game:GetService("UserInputService").InputEnded:Connect(function(inp)
							if inp.UserInputType == Enum.UserInputType.Keyboard then
								Key = inp.KeyCode
								b.DisplayEnumKey.Text = Key.Name
								yes:Disconnect()
								wait()
								KC = false
							end
						end)
					end
				end)

				local e = {}

				function e:newOnPressed(func)
					OnPressed = func
				end	
				function e:changeKey(func)
					OnPressed = func
				end			
				function e:changeState(bool)
					State = bool
					Color(State)
				end				
				function e:newText(Text)
					b.ToggleButtonText.Text = Text
				end			
				function e:Self()
					return b.ToggleButton
				end

				return e
			end
			function page:Slider(Text,Current,MinValue,MaxValue,OnSeeking)
				local b = {
					Sliderholder = Instance.new("Frame"),
					SliderholderLayout = Instance.new("UIListLayout"),
					Top = Instance.new("Frame"),
					TopLayout = Instance.new("UIListLayout"),
					SliderTitle = Instance.new("TextLabel"),
					SliderValue = Instance.new("TextBox"),
					SliderValueCorner = Instance.new("UICorner"),
					Slider = Instance.new("ImageButton"),
					SliderBarHolder = Instance.new("Frame"),
					SliderBarHolderCorner = Instance.new("UICorner"),
					SliderBar = Instance.new("Frame"),
					SliderBarCorner = Instance.new("UICorner")
				}
				Text = Text or 'Slider'
				MinValue = MinValue or 0
				MaxValue = MaxValue or 100
				OnSeeking = OnSeeking or function() end

				b.Sliderholder.Parent = x.PageView
				b.Sliderholder.BackgroundColor3 = Frame_Color_Opposite
				b.Sliderholder.BackgroundTransparency = .95
				b.Sliderholder.BorderSizePixel = 0
				b.Sliderholder.Position = UDim2.new(0, 0, 0.412995398, 0)
				b.Sliderholder.Size = UDim2.new(1, 0, 0, 46)

				b.Top.Parent = b.Sliderholder
				b.Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.Top.BackgroundTransparency = 1
				b.Top.BorderSizePixel = 0
				b.Top.Size = UDim2.new(1, 0, 0.5, 0)

				b.TopLayout.Parent = b.Top
				b.TopLayout.FillDirection = Enum.FillDirection.Horizontal
				b.TopLayout.SortOrder = Enum.SortOrder.LayoutOrder

				b.SliderTitle.Parent = b.Top
				b.SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderTitle.BackgroundTransparency = 1
				b.SliderTitle.BorderSizePixel = 0
				b.SliderTitle.Size = UDim2.new(0.8, 0, 0.99999994, 0)
				b.SliderTitle.Font = textfont
				b.SliderTitle.Text = Text
				b.SliderTitle.TextColor3 = Text_Color_Opposite
				b.SliderTitle.TextSize = textsize

				b.SliderValue.Parent = b.Top
				b.SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderValue.BackgroundTransparency = 1
				b.SliderValue.BorderSizePixel = 0
				b.SliderValue.Size = UDim2.new(0.2, 0, 1, 0)
				b.SliderValue.Font = textfont
				b.SliderValue.Text = tostring(Current)
				b.SliderValue.TextColor3 = Text_Color_Opposite
				b.SliderValue.TextSize = textsize

				b.SliderValueCorner.CornerRadius = UDim.new(0, 4)
				b.SliderValueCorner.Parent = b.SliderValue

				b.Slider.Parent = b.Sliderholder
				b.Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.Slider.BackgroundTransparency = 1
				b.Slider.BorderSizePixel = 0
				b.Slider.Position = UDim2.new(0, 0, 0.333804071, 0)
				b.Slider.Size = UDim2.new(1, 0, 0.5, 0)
				b.Slider.ImageTransparency = 1

				b.SliderBarHolder.Parent = b.Slider
				b.SliderBarHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderBarHolder.BackgroundTransparency = .9
				b.SliderBarHolder.Size = UDim2.new(1, 0, 1, 0)

				b.SliderBarHolderCorner.CornerRadius = UDim.new(0, 4)
				b.SliderBarHolderCorner.Parent = b.SliderBarHolder

				b.SliderBar.Parent = b.SliderBarHolder
				b.SliderBar.BackgroundColor3 = Frame_Color_Opposite
				b.SliderBar.BackgroundTransparency = .95
				b.SliderBar.Size = UDim2.new(1, 0, 1, 0)

				b.SliderBarCorner.CornerRadius = UDim.new(0, 4)
				b.SliderBarCorner.Parent = b.SliderBar

				b.SliderholderLayout.Parent = b.Sliderholder
				b.SliderholderLayout.SortOrder = Enum.SortOrder.LayoutOrder

				local uis = game:GetService("UserInputService")
				local editbox = b.SliderValue
				local sliderbar = b.SliderBar
				local isdragg = false
				local max = MaxValue
				local min = MinValue
				local current = 0
				local gui = sliderbar.Parent
				local movinggui = sliderbar
				local dragging
				local dragInput
				local dragStart
				local startPos
				do
					local z = (current-min)/max
					if -min > 0 then
						z = (current-min)/ (max - min)
					end
					movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
				end

				editbox.Changed:Connect(function()
					if not isdragg then
						local allowed = {
							[""] = true,
							["-"] = true
						}
						local text = editbox.Text

						if typeof(tonumber(text)) == nil then
							editbox.Text = text:sub(1, #text - 1)
						elseif typeof(tonumber(text)) == "number" then
							current = tonumber(text)  
							local z = (current-min)/max
							if -min > 0 then
								z = (current-min)/ (max - min)
							end
							movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
							OnSeeking(current)
						end
					end
				end)
				local function update(input)
					local delta = input.Position - dragStart
					local x = startPos.X.Scale + delta.X/b.Sliderholder.AbsoluteSize.X
					wait(.01)
					x = math.clamp(x, 0, 1)
					current = min + (max - min) * x
					local z = (current-min)/max
					if -min > 0 then
						z = (current-min)/ (max - min)
					end
					if x > 0 then
						if x < 1 then
							movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
						else
							movinggui.Size = UDim2.new(1,0, 1,0)
						end
					else
						movinggui.Size = UDim2.new(0, 0, 1, 0)
					end
					editbox.Text = math.round(current)
					OnSeeking(current)
				end

				gui.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						dragStart = input.Position
						startPos = movinggui.Size

						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
							end
						end)
					end
				end)

				gui.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end)

				uis.InputChanged:Connect(function(input)
					if input == dragInput and dragging then
						update(input)
					end
				end)
				local e = {}

				function e:newOnSeek(func)
					OnSeeking = func
				end				
				function e:newText(Text)
					b.SliderTitle.Text = Text
				end			
				function e:setCurrent(x)
					current = x
					local z = (current-min)/max
					if min < 0 then
						z = (current-min)/ (max - min)
					end
					movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
				end	
				function e:setSliderLimit(Min,Max)
					MinValue = Min or MinValue
					MaxValue = Max or MaxValue
				end
				function e:getCurrent()
					return current
				end	
				function e:Self()
					return b.Sliderholder
				end

				return e
			end

			return page
		end
		function tab:Center(pt)
			local x = {
				PageToggle = Instance.new("TextButton"),
				PageName = Instance.new("TextLabel"),
				Page = Instance.new("Frame",f),
				PageCorner = Instance.new("UICorner"),
				PageLayout = Instance.new("UIListLayout"),
				PageView = Instance.new("ScrollingFrame"),
				ViewLayout = Instance.new("UIListLayout")
			}
			--[[
			local UserInputService = game:GetService("UserInputService")
			local gui = x.PageName
			local movinggui = x.Page
			local dragging
			local dragInput
			local dragStart
			local startPos
			local function update(input)
				local delta = input.Position - dragStart
				wait(.01)
				movinggui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = movinggui.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)
			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
			]]

			x.Page.Name = pt
			x.Page.AnchorPoint = Vector2.new(0.5, 0.5)
			x.Page.BackgroundColor3 = color
			x.Page.Position = UDim2.new(0.5, 0, 0.5, 0)
			x.Page.Size = UDim2.new(0, 383, 0, 347)
			x.Page.Visible = false

			x.PageToggle.Parent = a.TabView
			x.PageToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageToggle.BackgroundTransparency = 1
			x.PageToggle.BorderSizePixel = 0
			x.PageToggle.Size = UDim2.new(1, 0, 0, 30)
			x.PageToggle.Font = textfont
			x.PageToggle.Text = pt
			x.PageToggle.TextColor3 = Text_Color_Opposite
			x.PageToggle.TextSize = textsize
			x.PageToggle.TextWrapped = true
			x.PageToggle.MouseButton1Click:Connect(function()
				if not bigOverlay then
					x.Page.Visible = not x.Page.Visible
				end
			end)

			x.PageName.Parent = x.Page
			x.PageName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageName.BackgroundTransparency = 1.000
			x.PageName.Size = UDim2.new(1, 0, 0.11, 0)
			x.PageName.Font = textfont
			x.PageName.Text = pt
			x.PageName.TextColor3 = Text_Color_Opposite
			x.PageName.TextSize = textsize
			x.PageName.TextWrapped = true
			x.PageName.InputEnded:Connect(function(z)
				--if z.UserInputType == Enum.UserInputType.MouseButton2 and not bigOverlay then
				if z.UserInputType == Enum.UserInputType.MouseButton1 and not bigOverlay then
					x.Page.Visible = false
				end
			end)

			x.PageView.Parent = x.Page
			x.PageView.Active = true
			x.PageView.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			x.PageView.BackgroundTransparency = 1.000
			x.PageView.Size = UDim2.new(1, 0, 0.89, 0)
			x.PageView.CanvasSize = UDim2.new(0, 0, 0, 0)
			x.PageView.ScrollBarThickness = 6
			x.PageView.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
			x.PageView.AutomaticCanvasSize = 'Y'
			x.PageView.LayoutOrder = 1

			x.ViewLayout.Parent = x.PageView
			x.ViewLayout.SortOrder = Enum.SortOrder.LayoutOrder
			x.ViewLayout.Padding = UDim.new(0, 1)

			x.PageCorner.CornerRadius = UDim.new(0, 4)
			x.PageCorner.Parent = x.Page

			x.PageLayout.Parent = x.Page
			x.PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
			x.PageLayout.Padding = UDim.new(0, 1)
			local page = {}

			function page:Button(Text,OnClick)
				local b = {
					Button = Instance.new("TextButton"),
					ButtonCorner = Instance.new("UICorner")
				}
				Text = Text or 'Button'
				OnClick = OnClick or function() end
				b.Button.Parent = x.PageView
				b.Button.BackgroundColor3 = Frame_Color_Opposite
				b.Button.BackgroundTransparency = 0.950
				b.Button.BorderSizePixel = 0
				b.Button.Size = UDim2.new(1, 0, 0, 30)
				b.Button.Font = textfont
				b.Button.TextColor3 = Text_Color_Opposite
				b.Button.TextSize = textsize
				b.Button.Text = Text
				b.Button.TextWrapped = true

				b.ButtonCorner.CornerRadius = UDim.new(0, 4)
				b.ButtonCorner.Parent = b.Button

				local ClickFunction = b.Button.MouseButton1Click:Connect(function()
					OnClick()
				end)

				local e = {}

				function e:newOnClick(func)
					ClickFunction:Disconnect()
					ClickFunction = b.Button.MouseButton1Click:Connect(function()
						func()
					end)
				end				
				function e:newText(Text)
					b.Button.Text = Text
				end			
				function e:Self()
					return b.Button
				end

				return e
			end
			function page:ToggleBind(Text,State,Key,OnPressed)
				local b = {
					ToggleButton = Instance.new("ImageButton"),
					ToggleButtonLayout = Instance.new("UIListLayout"),
					DisplayEnumKey = Instance.new("TextLabel"),
					DisplayEnumKeyCorner = Instance.new("UICorner"),
					ToggleButtonText = Instance.new("TextLabel")
				}
				Text = Text or "ToggleBind"
				State = State or false
				Key = Key or Enum.KeyCode.F
				OnPressed = OnPressed or function() end
				if typeof(Key) == 'string' then
					if Enum.KeyCode[string.upper(Key)] == nil then
						Key = Enum.KeyCode.F
					else
						Key = Enum.KeyCode[string.upper(Key)]
					end
				end

				b.ToggleButton.Parent = x.PageView
				b.ToggleButton.BackgroundColor3 = Frame_Color_Opposite
				b.ToggleButton.BackgroundTransparency = .95
				b.ToggleButton.BorderSizePixel = 0
				b.ToggleButton.Size = UDim2.new(1, 0, 0, 30)
				b.ToggleButton.ImageTransparency = 1

				b.ToggleButtonLayout.Parent = b.ToggleButton
				b.ToggleButtonLayout.FillDirection = Enum.FillDirection.Horizontal
				b.ToggleButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

				b.DisplayEnumKey.Parent = b.ToggleButton
				b.DisplayEnumKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.DisplayEnumKey.BackgroundTransparency = 1
				b.DisplayEnumKey.LayoutOrder = 1
				b.DisplayEnumKey.Position = UDim2.new(0.573333323, 0, 0, 0)
				b.DisplayEnumKey.Size = UDim2.new(0.206, 0, 1, 0)
				b.DisplayEnumKey.Font = textfont
				b.DisplayEnumKey.Text = Key.Name
				b.DisplayEnumKey.LayoutOrder = 1
				b.DisplayEnumKey.TextColor3 = Text_Color_Opposite
				b.DisplayEnumKey.TextSize = textsize
				b.DisplayEnumKey.TextWrapped = true

				b.DisplayEnumKeyCorner.CornerRadius = UDim.new(0, 4)
				b.DisplayEnumKeyCorner.Parent = b.DisplayEnumKey

				b.ToggleButtonText.Parent = b.ToggleButton
				b.ToggleButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.ToggleButtonText.BackgroundTransparency = 1
				b.ToggleButtonText.Size = UDim2.new(0.8, 0, 1, 0)
				b.ToggleButtonText.Font = textfont
				b.ToggleButtonText.Text = Text
				b.ToggleButtonText.TextColor3 = Text_Color_Opposite
				b.ToggleButtonText.TextSize = textsize
				b.ToggleButtonText.TextWrapped = true
				local function Color(x)
					if x then
						b.ToggleButton.BackgroundColor3 = Color3.new(0.0156863, 0.737255, 0.8)
						b.ToggleButton.BackgroundTransparency = .85
					else
						b.ToggleButton.BackgroundColor3 = Frame_Color_Opposite
						b.ToggleButton.BackgroundTransparency = .95
					end
				end
				Color(State)
				local binding = game:GetService("UserInputService").InputEnded:Connect(function(inp,gp)
					if inp.KeyCode == Key then
						local ji = false
						local function z()
							if ji == false  then
								ji = true
								OnPressed(State,gp)
								wait()
								ji = false
							end
						end z()
					end
				end)
				local KC = false

				b.ToggleButton.MouseButton1Click:Connect(function()
					State = not State
					Color(State)
				end)
				b.ToggleButton.MouseButton2Click:Connect(function()
					if not KC then
						KC = true
						local yes;yes = game:GetService("UserInputService").InputEnded:Connect(function(inp)
							if inp.UserInputType == Enum.UserInputType.Keyboard then
								Key = inp.KeyCode
								b.DisplayEnumKey.Text = Key.Name
								yes:Disconnect()
								wait()
								KC = false
							end
						end)
					end
				end)

				local e = {}

				function e:newOnPressed(func)
					OnPressed = func
				end	
				function e:changeKey(func)
					OnPressed = func
				end			
				function e:changeState(bool)
					State = bool
					Color(State)
				end				
				function e:newText(Text)
					b.ToggleButtonText.Text = Text
				end			
				function e:Self()
					return b.ToggleButton
				end

				return e
			end
			function page:Slider(Text,Current,MinValue,MaxValue,OnSeeking)
				local b = {
					Sliderholder = Instance.new("Frame"),
					SliderholderLayout = Instance.new("UIListLayout"),
					Top = Instance.new("Frame"),
					TopLayout = Instance.new("UIListLayout"),
					SliderTitle = Instance.new("TextLabel"),
					SliderValue = Instance.new("TextBox"),
					SliderValueCorner = Instance.new("UICorner"),
					Slider = Instance.new("ImageButton"),
					SliderBarHolder = Instance.new("Frame"),
					SliderBarHolderCorner = Instance.new("UICorner"),
					SliderBar = Instance.new("Frame"),
					SliderBarCorner = Instance.new("UICorner")
				}
				Text = Text or 'Slider'
				MinValue = MinValue or 0
				MaxValue = MaxValue or 100
				OnSeeking = OnSeeking or function() end

				b.Sliderholder.Parent = x.PageView
				b.Sliderholder.BackgroundColor3 = Frame_Color_Opposite
				b.Sliderholder.BackgroundTransparency = .95
				b.Sliderholder.BorderSizePixel = 0
				b.Sliderholder.Position = UDim2.new(0, 0, 0.412995398, 0)
				b.Sliderholder.Size = UDim2.new(1, 0, 0, 46)

				b.Top.Parent = b.Sliderholder
				b.Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.Top.BackgroundTransparency = 1
				b.Top.BorderSizePixel = 0
				b.Top.Size = UDim2.new(1, 0, 0.5, 0)

				b.TopLayout.Parent = b.Top
				b.TopLayout.FillDirection = Enum.FillDirection.Horizontal
				b.TopLayout.SortOrder = Enum.SortOrder.LayoutOrder

				b.SliderTitle.Parent = b.Top
				b.SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderTitle.BackgroundTransparency = 1
				b.SliderTitle.BorderSizePixel = 0
				b.SliderTitle.Size = UDim2.new(0.8, 0, 0.99999994, 0)
				b.SliderTitle.Font = textfont
				b.SliderTitle.Text = Text
				b.SliderTitle.TextColor3 = Text_Color_Opposite
				b.SliderTitle.TextSize = textsize

				b.SliderValue.Parent = b.Top
				b.SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderValue.BackgroundTransparency = 1
				b.SliderValue.BorderSizePixel = 0
				b.SliderValue.Size = UDim2.new(0.2, 0, 1, 0)
				b.SliderValue.Font = textfont
				b.SliderValue.Text = tostring(Current)
				b.SliderValue.TextColor3 = Text_Color_Opposite
				b.SliderValue.TextSize = textsize

				b.SliderValueCorner.CornerRadius = UDim.new(0, 4)
				b.SliderValueCorner.Parent = b.SliderValue

				b.Slider.Parent = b.Sliderholder
				b.Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.Slider.BackgroundTransparency = 1
				b.Slider.BorderSizePixel = 0
				b.Slider.Position = UDim2.new(0, 0, 0.333804071, 0)
				b.Slider.Size = UDim2.new(1, 0, 0.5, 0)
				b.Slider.ImageTransparency = 1

				b.SliderBarHolder.Parent = b.Slider
				b.SliderBarHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				b.SliderBarHolder.BackgroundTransparency = .9
				b.SliderBarHolder.Size = UDim2.new(1, 0, 1, 0)

				b.SliderBarHolderCorner.CornerRadius = UDim.new(0, 4)
				b.SliderBarHolderCorner.Parent = b.SliderBarHolder

				b.SliderBar.Parent = b.SliderBarHolder
				b.SliderBar.BackgroundColor3 = Frame_Color_Opposite
				b.SliderBar.BackgroundTransparency = .95
				b.SliderBar.Size = UDim2.new(1, 0, 1, 0)

				b.SliderBarCorner.CornerRadius = UDim.new(0, 4)
				b.SliderBarCorner.Parent = b.SliderBar

				b.SliderholderLayout.Parent = b.Sliderholder
				b.SliderholderLayout.SortOrder = Enum.SortOrder.LayoutOrder

				local uis = game:GetService("UserInputService")
				local editbox = b.SliderValue
				local sliderbar = b.SliderBar
				local isdragg = false
				local max = MaxValue
				local min = MinValue
				local current = 0
				local gui = sliderbar.Parent
				local movinggui = sliderbar
				local dragging
				local dragInput
				local dragStart
				local startPos
				do
					local z = (current-min)/max
					if -min > 0 then
						z = (current-min)/ (max - min)
					end
					movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
				end

				editbox.Changed:Connect(function()
					if not isdragg then
						local allowed = {
							[""] = true,
							["-"] = true
						}
						local text = editbox.Text

						if typeof(tonumber(text)) == nil then
							editbox.Text = text:sub(1, #text - 1)
						elseif typeof(tonumber(text)) == "number" then
							current = tonumber(text)  
							local z = (current-min)/max
							if -min > 0 then
								z = (current-min)/ (max - min)
							end
							movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
							OnSeeking(current)
						end
					end
				end)
				local function update(input)
					local delta = input.Position - dragStart
					local x = startPos.X.Scale + delta.X/b.Sliderholder.AbsoluteSize.X
					wait(.01)
					x = math.clamp(x, 0, 1)
					current = min + (max - min) * x
					local z = (current-min)/max
					if -min > 0 then
						z = (current-min)/ (max - min)
					end
					if x > 0 then
						if x < 1 then
							movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
						else
							movinggui.Size = UDim2.new(1,0, 1,0)
						end
					else
						movinggui.Size = UDim2.new(0, 0, 1, 0)
					end
					editbox.Text = math.round(current)
					OnSeeking(current)
				end

				gui.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						dragStart = input.Position
						startPos = movinggui.Size

						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
							end
						end)
					end
				end)

				gui.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end)

				uis.InputChanged:Connect(function(input)
					if input == dragInput and dragging then
						update(input)
					end
				end)
				local e = {}

				function e:newOnSeek(func)
					OnSeeking = func
				end				
				function e:newText(Text)
					b.SliderTitle.Text = Text
				end			
				function e:setCurrent(x)
					current = x
					local z = (current-min)/max
					if min < 0 then
						z = (current-min)/ (max - min)
					end
					movinggui.Size = UDim2.new(0,0, 1,0):Lerp(UDim2.new(1,0, 1,0),math.clamp(z,0,1))
				end	
				function e:setSliderLimit(Min,Max)
					MinValue = Min or MinValue
					MaxValue = Max or MaxValue
				end
				function e:getCurrent()
					return current
				end	
				function e:Self()
					return b.Sliderholder
				end

				return e
			end

			return page
		end

		return tab
	end

	return n
end
return m
