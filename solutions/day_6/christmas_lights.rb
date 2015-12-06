module ChristmasLights

  def let_there_be_light!(params)
    params['instructions'].each do |instruction|
      action, *coords = parse_instruction(instruction)
      transition params[action], *coords.map(&:to_i)
    end
    brightness
  end

  private

  def lights
    @lights ||= Array.new(1000) { Array.new(1000) { 0 } }
  end

  def transition(z, a, b, c, d)
    (b..d).each do |x|
      (a..c).each do |y|    
        lights[x][y] = z.call lights[x][y]
      end
    end
  end

  def brightness
    lights.flatten.reduce(:+)
  end

  def parse_instruction(instruction)
    instruction.scan(instruction_format).flatten
  end

  def instruction_format
    /(turn on|turn off|toggle) (\d+)\,(\d+) through (\d+)\,(\d+)/
  end

end

include ChristmasLights
