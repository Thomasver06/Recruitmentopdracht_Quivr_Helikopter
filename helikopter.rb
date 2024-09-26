class Helikopter
  RICHTINGEN = %w(noord oost zuid west)

  def initialize(x, y, z, richting)                                       # geeft de nieuwe instance van Helikoper zijn beginpositie en richting
    @x = x
    @y = y
    @z = z
    @richting = richting
  end

  def vlieg(instructies)                                                       # kijkt een voor een naar de instructies en voert de overeenkomstige beweging uit
    instructies.each_char do |char|
      case char
      when "R" then keer_naar_rechts
      when "L" then keer_naar_links
      when "V" then ga_vooruit
      when "U" then ga_omhoog
      when "D" then ga_omlaag
      else                                                                     # bij een ongeldige instructie wordt het programma afgebroken
        puts "#{char} is geen geldige instructie"
        exit
      end
    end
    locatie                                                                    # returns eindlocatie
  end

  private                                                                      # de volgende functies kunnen niet rechtstreeks opgeroepen worden buiten de klas

  def keer_naar_rechts                                                         # richt de helikopter naar de volgende windrichting met de klok mee
    richting_index = RICHTINGEN.index(@richting)
    @richting = RICHTINGEN[(richting_index + 1) % RICHTINGEN.length]
  end

  def keer_naar_links                                                          # richt de helikopter naar de volgende windrichting tegen de klok in
    richting_index = RICHTINGEN.index(@richting)
    @richting = RICHTINGEN[(richting_index - 1) % RICHTINGEN.length]
  end

  def ga_vooruit                                                               # kijkt naar waar de helikopter gericht staat en past het overeenkomsig coordinaat aan
    case @richting
    when "noord" then @y += 1
    when "oost" then @x += 1
    when "zuid" then @y -= 1
    when "west" then @x -= 1
    else                                                                       # bij een ongeldige richting word het programma afgebroken
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

  def locatie                                                                  # defenieerd hoe de eindlokatie weergegeven wordt
    "#{@x} #{@y} #{@z} #{@richting}"
  end
end

def check_input                                                                # kijkt als er genoeg argumenten gegeven zijn en zet deze in variable
  if ARGV.length == 5
    x, y, z, richting, instructies = ARGV[0..4]
    check_input_valid(x, y, z, richting, instructies)
  else                                                                         # als dit niet het geval is gaat hij nieuwe input vragen
    puts "5 argumenten verwacht, #{ARGV.length} argument(en) gegeven."
    get_input
  end
end

def check_input_valid(x, y, z, richting, instructies)                          # kijkt als de input voldoet aan de voorwaarden
  positie = [x, y, z]
  check_positie = positie.all? { |arg| arg =~ /^-?\d+$/ }

  richtingen = %w(noord oost zuid west)
  check_richting = richtingen.include?(richting)

  check_instructies = instructies =~ /^[UDVRL]+$/

  if check_positie && check_richting && check_instructies                      # als alle inputs voldoen aan de voorwaarden returns hij de inputs
    [x, y, z, richting, instructies]
  else                                                                         # als dit niet is gaat hij niewe inputs vragen
    puts "Argumenten voldoen niet aan verwachting."
    get_input
  end
end

def get_input                                                                  # vraagt voor nieuwe inputs als de vorige leeg/ongeldig waren
  puts "Input: ( <x> <y> <z> <richt> <instruct> )"
  input = gets.chomp
  if input.split(" ").length == 5
    x, y, z, richting, instructies = input.split(" ")
    check_input_valid(x, y, z, richting, instructies)
  else                                                                         # als de nieuwe inputs leeg/ongeldig zijn vraagt hij er terug nieuwe
    puts "5 argumenten verwacht, #{input.split(" ").length} argument(en) gegeven."
    get_input
  end

end


x, y, z, richting, instructies = check_input                              # neemt de nagekeken inputs en zet deze in de overeenkomstige variable
helikopter = Helikopter.new(x.to_i, y.to_i, z.to_i, richting)             # maakt nieuwe instance van Helikopter met gegeven inputs
puts helikopter.vlieg(instructies)                                        # instance van Helikopter voert vlieginstructies uit en print eindlocatie
