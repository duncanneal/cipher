class Cipher
  ALPHABET = ('A'..'Z').to_a # => ['A', 'B', 'C', ...]

    #first = caesar(text, 6)
    #second = caesar(text, 0)
    #third = caesar(text, 17)
    #fourth = caesar(text, 3)
    #fifth = caesar(text, 4)
    #sixth = caesar(text, 13)

  def self.vigenere(keyword, text)
    deciphered_keyword = caesar_guess(keyword)
    keys = deciphered_keyword.each_char.map { |char| ALPHABET.index(char) }
    iterator = 0

    text.chars.map { |char|

      if ALPHABET.include?(char)
        if iterator == keys.length
          iterator = 0
        end
        
      key = ALPHABET.rotate(keys[iterator].to_i)
        iterator += 1
        ALPHABET[key.index(char)]
      else
        char
      end

  end

  # Solve a Caesar cipher with a given offset
  #
  def self.caesar(text, offset)
    key = ALPHABET.rotate(offset) # the key is our alphabet shifted by an offset
    text.chars.map { |char|       # loop through each character, mapping them to a new array
      if ALPHABET.include?(char)  #   if the character is in the alphabet
        ALPHABET[key.index(char)] #     find the where it is in the key, use that to look it up in the alphabet
      else                        #   otherwise
        char                      #     just turn the character (it must be a space, punctuation, etc.)
      end                         #
    }.join                        # join the mapped characters back together as a string
  end

  # Solve a Caesar cipher for a single word without an offset by guessing and matching an English word
  #
  def self.caesar_guess(text)
    26.times do |i|                      # for 0 through 25 as i (length of the alphabet)
      guess = caesar(text, i)            #   solve with i
      return guess if is_english?(guess) #     return the guess if it's an english word
    end                                  #
    text                                 # returns the original text if no word could be found
  end

  # Use the external `look` command to see if the given word is a dictionary word
  #   http://unixhelp.ed.ac.uk/CGI/man-cgi?lo
  #
  def self.is_english?(word)
    `look #{word}`.lines.first.to_s.chomp == word.downcase
  end
end
