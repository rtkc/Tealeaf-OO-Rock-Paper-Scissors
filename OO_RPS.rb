class Hand
  include Comparable
  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=> (another_hand)
    if @value == another_hand.value 
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p') 
      1
    else 
      -1
    end
  end

  def display_winning_message
    case @value
    when 'p'
      puts "Paper wraps rock!"
    when 'r'
      puts 'Rock crushes scissors!'
    when 's'
      puts 'Scissors shreds paper!'
    end
  end
end

class Human 
  attr_reader :name
  attr_accessor :hand

  def initialize(n)
    @name = n
  end

  def pick_hand
    begin 
      puts "Please pick rock, paper or scissors (r, p, s)."
      c = gets.chomp.downcase 
    end until Blackjack::CHOICES.keys.include?(c)
    self.hand = Hand.new(c)
  end

  def display_hand
    puts "You picked #{self.hand.value}"
  end
end

class Computer 
  attr_reader :name
  attr_accessor :hand

  def initialize(n)
    @name = n
  end

  def pick_hand
    self.hand = Hand.new(Blackjack::CHOICES.keys.sample)
  end

  def display_hand
    puts "#{name} picked #{self.hand.value}"
  end
end


class Blackjack
  CHOICES = {'p' => 'paper', 'r' => 'rock', 's' => 'scissors'}
  attr_reader :human, :computer

  def initialize
    @human = Human.new('You')
    @computer = Computer.new('R2D2')
  end

  def compare_hands
    if human.hand == computer.hand 
      puts "It's a tie!"
    elsif human.hand > computer.hand
      human.hand.display_winning_message
      puts "#{human.name} won!"
    else human.hand < computer.hand
      computer.hand.display_winning_message
      puts "#{computer.name} won!"
    end
  end

  def play
    begin
      human.pick_hand
      puts human.display_hand
      computer.pick_hand
      puts computer.display_hand
      compare_hands
      puts 'Play again? (y/n)'
      play_again = gets.chomp
    end until play_again == 'n'
  end
end 

game = Blackjack.new.play