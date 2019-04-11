# From https://thoughtbot.com/upcase/videos/week-1-advanced-ruby

module Flashcards #namespace to avoid name clashes in case of duplication
  class Application
    # Create array of decks
    def initialize
      @decks = []
    end

    # append new deck to end of array to store it
    def <<(deck)
      @decks << deck
    end

    def play
      display_decks
      puts "Pick a deck: "
      deck = get_deck
      deck.play
    end

    def display_decks
      @decks.each { |deck| puts deck.name }
    end

    def get_deck
      name = gets.chomp
      # use inbuilt detect method, similar to each but returns value if true
      @decks.detect { |deck| deck.name == name }
    end
  end

  class Card
    # read/write vars
    attr_accessor :front, :back

    def initialize(front, back)
      @front = front #instance variable
      @back = back
    end

    # if guess correct, return true
    def correct?(guess)
      guess == @back
    end

    def play
      print "#{front} >"
      guess = gets.chomp
      if correct?(guess)
        puts "Correct"
      else
        puts "Incorrect. The answer was #{back}"
      end
    end
  end

  class MultipleAnswerCard < Card #inherits from Card
    def correct?(guess)
      answers = @back.split(",")
      answers.any? { |answer| answer == guess } # any? is an Array method, returns true "if" statement returns true
    end
  end

  class Deck
    # read/write array of cards
    attr_reader :cards, :name

    # deck has a name
    def initialize(name)
      @name = name
      @cards = []
    end

    # << appends a card to the end of the array
    def <<(card)
      @cards << card
    end

    def play
      puts "Playing the #{name} deck."
      shuffle
      @cards.each(&:play) # & calls(to proc) method on play
    end

    # uses built in shuffle method to shuffle and update var
    def shuffle
      @cards.shuffle!
    end
  end
end

# :: does scope resolution
card1 = Flashcards::Card.new("cat", "neko")
card2 = Flashcards::Card.new("dog", "inu")
card3 = Flashcards::Card.new("snake", "hebi")

deck = Flashcards::Deck.new("Japanese animals")
deck << card1
deck << card2
deck << card3

card4 = Flashcards::Card.new("cat", "Katze")
card5 = Flashcards::Card.new("dog", "Hund")

deck2 = Flashcards::Deck.new("German")
deck2 << card4
deck2 << card5

deck3 = Flashcards::Deck.new("Japanese loanwords")
card6 = Flashcards::MultipleAnswerCard.new("Violin", "baoirin,viiorin")
card7 = Flashcards::MultipleAnswerCard.new("Violin", "baoirin,viiorin")
deck3 << card6
deck3 << card7

app = Flashcards::Application.new
app << deck
app << deck2
app << deck3
app.play

=begin

deck.cards.each do |card|
  front = card.front
  back = card.back

  print "#{front} >"
  guess = gets.chomp

  if card.correct?(guess)
    puts "Correct"
  else
    puts "Incorrect. The answer was #{back}"
  end
end

=end
