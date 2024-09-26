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
    puts "5 argumenten verwacht, #{ARGV.length} argument(en) gegeven."
    get_input
  end
end

def check_input_valid(x, y, z, richting, instructies)
  positie = [x, y, z]
  check_positie = positie.all? { |arg| arg =~ /^-?\d+$/ }

  richtingen = %w(noord oost zuid west)
  check_richting = richtingen.include?(richting)

  check_instructies = instructies =~ /^[UDVRL]+$/

  if check_positie && check_richting && check_instructies
    [x, y, z, richting, instructies]
  else
    puts "Argumenten voldoen niet aan verwachting."
    get_input
  end
end

def get_input
  puts "Input: ( <x> <y> <z> <richt> <instruct> )"
  input = gets.chomp
  if input.split(" ").length == 5
    x, y, z, richting, instructies = input.split(" ")
    check_input_valid(x, y, z, richting, instructies)
  else
    puts "5 argumenten verwacht, #{input.split(" ").length} argument(en) gegeven."
  end

end


x, y, z, richting, instructies = check_input
helikopter = Helikopter.new(x.to_i, y.to_i, z.to_i, richting)
puts helikopter.vlieg(instructies)
