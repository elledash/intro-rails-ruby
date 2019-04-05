number = rand(10) + 1 #shift range from 0-9 to 1-10

puts "Welcome to my guessing game"
puts "-" * 20

won = false

5.times do
  print "Guess my number > "
  guess = gets.to_i

  if guess == number
    won = true
    break
  end
end

if won
  puts "You win"
else
  puts "You lost. The number was #{number}"
end
