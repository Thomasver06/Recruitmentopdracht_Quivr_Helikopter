class Helikopter
  RICHTINGEN = %w(noord oost zuid west)

  def initialize(x, y, z, richting)
    @x = x
    @y = y
    @z = z
    @richting = richting
  end

  def vlieg(instructies)
    instructies.each_char do |char|
      case char
      when "R" then keer_naar_rechts
      when "L" then keer_naar_links
      when "V" then ga_vooruit
      when "U" then ga_omhoog
      when "D" then ga_omlaag
      else
        puts "#{char} is geen geldige instructie"
        exit
      end
    end
    locatie
  end

  private

  def keer_naar_rechts
    richting_index = RICHTINGEN.index(@richting)
    @richting = RICHTINGEN[(richting_index + 1) % RICHTINGEN.length]
  end

  def keer_naar_links
    richting_index = RICHTINGEN.index(@richting)
    @richting = RICHTINGEN[(richting_index - 1) % RICHTINGEN.length]
  end

  def ga_vooruit
    case @richting
    when "noord" then @y += 1
    when "oost" then @x += 1
    when "zuid" then @y -= 1
    when "west" then @x -= 1
    else
      puts "Geen geldige richting."
      exit
    end
  end

  def ga_omhoog
    @z += 1
  end

  def ga_omlaag
    @z -= 1
  end

  def locatie
    "#{@x} #{@y} #{@z} #{@richting}"
  end
end

def check_input
  if ARGV.length == 5
    x, y, z, richting, instructies = ARGV[0..4]
    check_input_valid(x, y, z, richting, instructies)
  else
    puts "5 argumenten zijn nodig, #{ARGV.length} argument(en) zijn gegeven \nInput: (<x> <y> <z> <richting> <instructies>)"
    input = gets.chomp
    x, y, z, richting, instructies  = input.split(" ")
    check_input_valid(x, y, z, richting, instructies)
  end
end

def check_input_valid(x, y, z, richting, instructies)
  if ARGV.length == 5
    check_coordinaten = ARGV[0..2].all? { |arg| arg =~ /^-?\d+$/ }

    richtingen = %w(noord oost zuid west)
    check_richting = richtingen.include?(ARGV[3])

    check_instructies = ARGV[4] =~ /^[UDVRL]+$/

    if check_coordinaten && check_richting && check_instructies
      return
    else
      puts "Input voorbeeld: helikopter 200 -5 0 west UURVVVLVVRRVD"
      exit
    end
  else
    puts "Input: helikopter <x> <y> <z> <richting> <instructies>"
    exit
  end
end


check_input

x, y, z, riching = ARGV[0..3]
instructies = ARGV[4]

helikopter = Helikopter.new(x.to_i, y.to_i, z.to_i, riching)
puts helikopter.vlieg(instructies)