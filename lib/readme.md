# SpecterX Library

## Library

```lua
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
```

## Create Window

```lua
local Window = redzlib:MakeWindow({
  Title = "redz Hub : Blox Fruits",
  SubTitle = "by redz9999",
  SaveFolder = "testando | redz lib v5.lua"
})
```

## Create Window

## Icon

```lua
Window:AddMinimizeButton({	
    Button = { Image = "rbxassetid://94800455817009", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 5) },
})
```

## Create Tab

```lua
local Tab1 = Window:MakeTab({"Um", "cherry"})
```

## Set Theme

```lua
redzlib:SetTheme("Darker")
```

## Selected Tab

```lua
Window:SelectTab(Tab1)
```

## Section

```lua
local Section = Tab1:AddSection({"Section"})
```

## Paragraph

```lua
local Paragraph = Tab1:AddParagraph({"Paragraph", "This is a Paragraph\nSecond Line"})
```

## Button

```lua
local Button = Tab1:AddButton({"Test",function()
    print("Hello, World!")
end
})
```

## Toggle 1

```lua
local Toggle = Tab1:AddToggle({
  Name = "Toggle",
  Default = false
  Callback = function(state)
    
  end
})
```

## Toggle 2

```lua
local Toggle = Tab1:AddToggle({
  Name = "Toggle",
  Description = "Toggle description",
  Default = false
  Callback = function(state)
    
  end
})
```

## Dialog

```lua
local Dialog = Window:Dialog({
  Title = "Dialog",
  Text = "This is a Dialog",
  Options = {
    {"Confirm", function()
      
    end},
    {"Maybe", function()
      
    end},
    {"Cancel", function()
      
    end}
  }
})
```

## Dropdown

```lua
local Dropdown = Tab1:AddDropdown({
  Name = "Players List",
  Description = "Select the <font color='rgb(88, 101, 242)'>Number</font>",
  Options = {"one", "two", "three"},
  Default = "two",
  Flag = "dropdown teste",
  Callback = function(Value)
    
  end
})
```

## Slider

```lua
Tab1:AddSlider({
  Name = "Slider",
  Min = 1,
  Max = 10,
  Increase = 1,
  Default = 5,
  Callback = function(Value)
    
  end
})
```

