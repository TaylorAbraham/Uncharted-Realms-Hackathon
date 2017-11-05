require "Script.card"
Player = {deck={}, hand={}, health = 30, name = "No Name", field={},deckSize=30 }


function Player:new(deck, name)

  setmetatable({}, Player)
  self.deck = deck
  self.name = name
  for i=1,3 do table.insert(self.hand,i,popDeck()) end
  return self
end

function newHand()
  for i=1,3 do table.insert(hand,i, popDeck()) end
end

function Player:draw()
  table.insert(self.hand, -1, popDeck())
end 

function popDeck()
  local temp = deck[1]
  table.remove(deck, 1)
  print(temp.power)
  return temp
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
