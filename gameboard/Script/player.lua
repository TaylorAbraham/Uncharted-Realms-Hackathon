require "Script.card"

Player = {}
Player.__index = Player


function Player:new(deck, name, hand, field, handSize, deckSize, fieldSize)
  local pl ={}
  setmetatable(pl, Player)
  pl.deck = deck
  pl.name = name
  pl.health=30
  pl.field=field
  pl.hand=hand
  pl.handSize = handSize;
  pl.deckSize = deckSize;
  pl.fieldSize = fieldSize;
  pl.exit=false
  return pl
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
  
  for i=1, self.handSize do
    if(hand[i].clock == 0) then
      if(self.fieldSize <=4) then
        table.insert(self.field, self:popHand(i))
        self.fieldSize = self.fieldSize + 1     
        table.insert(self.hand,i , self.deck[1])
        table.remove(self.deck, 1)
      end
    end

    if(hand[i].clock > 0) then
      hand[i].clock = hand[i].clock - 1
    end
  end

  for i=1, self.fieldSize do
    field[i]:drawpng_front(300*i - 200, 200)
    if(p1.health > 0) then
      self:attack(self.field[i])    
    else
      p1.health = 0
    end
  end

end


function Player:attack(card)
  self.health=self.health-card.power
end

