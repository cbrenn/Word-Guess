require 'pry'
require 'faker'

class Game
  def initialize
    @word = GameData.new.easy_word.downcase
    @user_choice = ''
    @bad_array = []
    @guess_string = ''
    @change_split_word = []
    @picture = GameData.new.picture
  end
  def level
    print "would you like to play easy or hard?\n"
    answer = gets.chomp.downcase
    if answer == "easy"
      print "I hope you know your Pokemon.\n"
      @word = GameData.new.easy_word.downcase
    else
      print "There are no spaces in this Rick and Morty quote.\n"
      @word = GameData.new.hard_word.downcase
    end
  end


  def summary
    puts "This is a summary the word is #{@word}"
    puts "This is a check on #{@picture}"
    puts "This is a check on #{@word}"
  end

  # Verbs
  # input
  def user_input
    puts 'Choose a letter please'
    @user_choice = gets.chomp.downcase


    until @user_choice.length == 1
      puts 'Hey! Pick a single letter.'
      @user_choice = gets.chomp.downcase
    end

    while /\A\d+\z/.match(@user_choice)
      puts 'Letters only please.'
      @user_choice = gets.chomp.downcase
    end
    guess
  end

  # guess
  def guess
    if @word.include?(@user_choice)
      print "Good guess that letter is in the word!\n"
      print "\n"
      print "\n"
      #if @change_split_word.include?("_")
        print "Letters Guessed: #{@bad_array}\n"
        display_anchor
        display_word
      #else
      #   print_winner
      #   puts @change_split_word
      # end

    else
      if @bad_array.length == 5
        print "You lose!\n"
        print "The answer was #{@word}.\n"
      else
        print "That was wrong, please guess again.\n"
        print "\n"
        @bad_array << @user_choice
        print "Wrong Letters Guessed: #{@bad_array}\n"
        @picture.delete_at(3)
        display_anchor
        display_word
      end
    end
  end


  def print_baddies
    puts ' X ' * @bad_array.length
  end

  def print_winner
    print "You won! Good job!\n"
    print "  Welcome to Turtania! \n"
    print "               🌺    \n "
    print "          ___/')    \n"
    print "          /= =\\/   \n"
    print "         /= = =\\   \n"
    print " 🌴🌴🌴     ^--|--^    🌺\n"

  end
  def display_anchor
    @picture.each do |element|
      puts element
    end
  end

  def first_display
    print "Welcome to the word guess game. You have six guesses to figure out the letters, as represented by the rising anchor.\n"
    display_anchor
    print "Letters in the mystery word are represented by the underscore.\n"

    level

    @change_split_word = Array.new(@word.length, '_')
    puts @change_split_word.join
  end

  def display_word
    split_word = @word.split('')
    i = 0
    split_word.each do |letter|
      #binding.pry
      if letter.include?(@user_choice)
        @change_split_word[i] = split_word[i]
      end
      i += 1
    end
    print "#{@change_split_word.join}\n"
    if @change_split_word.include?("_")
      user_input
    else
      print_winner
    end
  end
end

class GameData
  attr_accessor :picture, :easy_word, :hard_word
  def initialize
    @picture = ["                  🌞",
                "            ☁️       ",
                "🌊🌊 ⛵ 🌊🌊🌊🌊⁣🌊🌊🌊 ",
                "     |             ",
                "     |      🐡     ",
                "     |     🐋       ",
                "     |             ",
                "     |    🐬       ",
                "     |             ",
                "     ⚓️             "]

    @easy_word = Faker::Pokemon.name
    @hard_word = (Faker::RickAndMorty.quote).gsub!(/[^0-9A-Za-z]/, '')
  end
end

# new_picture = Picture.new
# new_picture.build_picture

 new_game = Game.new
#new_game.print_winner
 #new_game.display_anchor
 # new_game.summary
 new_game.first_display
 new_game.user_input
