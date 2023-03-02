# frozen_string_literal: true

def check_guess(code, guess)
  result = %w[X X X X]
  misplaced_numbers = 0
  included = 0
  correct_numbers = 0
  guess.each_with_index do |g, index|
    code.each_with_index do |c, pos|
      if g == c
        if index == pos
          result[pos] = c
          correct_numbers += 1
        end
      end
    end
  end

  guess.each do |val|
    if code.include?(val)
      included += 1
    end
  end

  if guess == code
    puts 'Congratulations! you broke the code!'
  else
    puts "#{result[0]} - #{result[1]} - #{result[2]} - #{result[3]} correct numbers: #{included}"
  end
  return result
end

def player_guess
  code = [rand(1..9), rand(1..9), rand(1..9), rand(1..9)]
  i = 12

  loop do
    if i == 1
      puts 'Only 1 guess left!'
    else
      puts "#{i} guesses left"
    end
    puts 'Please enter a code (4 numbers without separation)'
    guess = gets.chomp.split('').map!(&:to_i)
    break if check_guess(code, guess) == code

    i -= 1
    if i.zero?
      puts "Game over! you didn't break the code!"
      break
    end
  end
end

def computer_guess
  puts "Please enter a code (4 numbers without separation)...I will close my eyes, I won't look!, I swear!"
  code = gets.chomp.split('').map!(&:to_i)
  result = Array.new(4)
  i = 1

  loop do
    puts "try N°#{i}"
    guess = Array.new(4)
    for n in 0..3 do
      if result[n] != "X"
        guess[n] = result[n]
      else guess[n] = rand(1..9)
      end
    end
    result = check_guess(code, guess)
    p guess
    break if result == code
    
    i += 1
    if i > 12
      puts "Game over! I didn't guess the code!"
      break
    end
  end
end

puts "Welcome to Mastermind! \n \n
              ********************GAME RULES********************\n
In this variation of Mastermind, the code breaker have 12 trys to guess the secret code.\n
The code is a pattern of 4 digits from 1 to 9, duplicates are allowed. \n
Every time the code breaker enters a code, the screen will show how many entered numbers exists in the code \n
and witch of them are correctly positioned.\n
              ***************************************************"
puts "Do you want to be a code maker or a code breaker?"
puts "press 1 for code maker and 2 for code breaker"
response = gets.chomp.to_i

if response == 1
  computer_guess
elsif response == 2
  player_guess
else
  puts "incorrect ansewr"
end

