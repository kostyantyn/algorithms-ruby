# encoding: UTF-8

class Spotlight
  def initialize(word, file)
    @file = file
    @word = parse(word)
  end
  
  def parse(word)
    word.each_char.inject({}) do |hash, char|
      hash[char] = hash.has_key?(char) ? hash[char] + 1 : 1
      hash
    end
  end
  
  def seek
    result = []
    map    = {}
    File.open(@file, 'r') do |io|
      io.each_line do |line|
        map.clear
        line.each_char do |char|
          if @word.has_key?(char)
            map[char] = map.has_key?(char) ? map[char] + 1 : 1
            break if map[char] > @word[char]
          elsif char == "\n"
            result << line.chomp
          else
            break
          end
        end
      end
    end
    result
  end
end

result = 1.upto(20).map do
  start = Time.now
  Spotlight.new('австралопітек', 'vocabulary.txt').seek
  Time.now - start 
end

puts "min: #{result.min}"
puts "avg: #{result.inject(0.0, :+) / 20}"
puts "max: #{result.max}"