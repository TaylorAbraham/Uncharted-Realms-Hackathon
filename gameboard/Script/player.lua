require "Script.card"
Player = {}
Player.__index = Player


function Player:new(deck, name)
  local pl ={}
  setmetatable(pl, Player)
  pl.deck = deck
  pl.name = name
  pl.health=30
  pl.field={}
  pl.hand={}
  pl.exit=false
  pl.fieldsize=0
  return pl
end

function Player:drawHand()
  for i=1,3 do table.insert(self.hand,i,self:popDeck()) end
end


function Player:draw()
  table.insert(self.hand, -1, self:popDeck())
end 

function Player:popDeck()
  local temp = self.deck[1]
  table.remove(self.deck, 1)
  return temp
end

function Player:popHand(i)
  local temp = self.hand[i]
  table.remove(self.hand,i)
  return temp
end 

function Player:turn()
  self:draw()
  for i, card in ipairs(self.hand) do
      if(card.clock==0)then
        table.insert(self.field,-1,self:popHand(i))
      end
  end
    
  for j, crd in ipairs(self.field) do
    self:attack(crd)
  end
  
  for k, cad in ipairs(self.hand) do
    cad.clock=cad.clock-1
    --print(cad.clock)
  end   
      
  return self.exit

end

function Player:attack(card)
  self.health=self.health-card.power
  print(self.health)
  if(p1.health<=0)then
    self.exit=true
  end


end

--pass in list of cards from main based off intial card selections by the user
--[[local function createDeck(new)
  cards = new
  return cards
end 
local function draw()
    if(first == false)then
      for i=1,3 do hand[i] = popleft(deck) end
      firstturn=true
    else
      table.insert(hand,-1,popleft(deck))
    end
end

local function pushleft (list, value)
  local first = list[0] - 1
  list[0] = first
  list[first] = value
  end

local function pushright (list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
  end

local function popleft (list)
  local first = list[0] 
  if first > list[-1] then error("list is empty") end
  local value = list[first]
  list[first] = nil        -- to allow garbage collection
  list[0] = first + 1
  return value
  end

local function popright (list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil         -- to allow garbage collection
  list.last = last - 1
  return value
  end

local function printDeck()
  for i=1, 30 do deck[i].printCard() end
  end--]]
