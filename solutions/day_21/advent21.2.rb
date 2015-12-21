#!/usr/bin/env ruby

@boss = {
  hp: 100,
  damage: 8,
  armor: 2
}

shop = {
  weapons: [
    {cost: 8, damage: 4, armor: 0},
    {cost: 10, damage: 5, armor: 0},
    {cost: 25, damage: 6, armor: 0},
    {cost: 40, damage: 7, armor: 0},
    {cost: 74, damage: 8, armor: 0},
  ],
  armor: [
    { cost: 0, damage: 0, armor: 0},
    { cost: 13, damage: 0, armor: 1},
    { cost: 31, damage: 0, armor: 2},
    { cost: 53, damage: 0, armor: 3},
    { cost: 75, damage: 0, armor: 4},
    { cost: 102, damage: 0, armor: 5},
  ],
  rings: [
    { cost: 0, damage: 0, armor: 0},
    { cost: 0, damage: 0, armor: 0},
    { cost: 25, damage: 1, armor: 0},
    { cost: 50, damage: 2, armor: 0},
    { cost: 100, damage: 3, armor: 0},
    { cost: 20, damage: 0, armor: 1},
    { cost: 40, damage: 0, armor: 2},
    { cost: 80, damage: 0, armor: 3},
  ]
}

def fight(my_hp, my_damage, my_armor)
  boss = @boss.dup
  until(my_hp <= 0 || boss[:hp] <= 0) do
    boss[:hp] -= [(my_damage - boss[:armor]), 1].max
    break if boss[:hp] <= 0
    my_hp -= [(boss[:damage] - my_armor), 1].max
  end
  my_hp > boss[:hp]
end

costs = []

shop[:weapons].each do |weapon|
  shop[:armor].each do |armor|
    shop[:rings].permutation(2).each do |rings|
      my_damage = weapon[:damage] + rings.map{|r| r[:damage]}.reduce(:+)
      my_armor = armor[:armor] + rings.map{|r| r[:armor]}.reduce(:+)
      cost = [weapon, armor, rings].flatten.map{|i| i[:cost]}.reduce(:+)
      if !fight(100, my_damage, my_armor)
        costs << cost
      end
    end
  end
end

p costs.max
