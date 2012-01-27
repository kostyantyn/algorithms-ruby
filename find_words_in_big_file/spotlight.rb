# encoding: UTF-8

class Spotlight
  def initialize(word, file)
    @file  = file
    @word  = word
    @chars = parse(word)
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
        next if line.size > @word.size
        next if result[9] && line.size <= result[9].size
        map.clear
        line.each_char do |char|
          if @chars.has_key?(char)
            map[char] = map.has_key?(char) ? map[char] + 1 : 1
            break if map[char] > @chars[char]
          elsif char == "\n"
            result << line.chomp
            result.sort! { |a, b| b.length <=> a.length }
          else
            break
          end
        end
      end
    end
    result
  end
end

p Spotlight.new('австралопітек', 'vocabulary.txt').seek.first(10)