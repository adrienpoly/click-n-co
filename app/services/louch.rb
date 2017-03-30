# Encoding: utf-8
require 'json'
class Louch
  @stopwords = JSON.parse(open("app/services/stopwords_fr.json","r").read)
  @know_words = JSON.parse(open("app/services/dictionnary.json","r").read)
  SUFFIX = %w(em é ji oc ic uche ès).freeze

  def self.translate(sentence)
    louchebem_sentence = ""
    louchebem_words = sentence.scan(/([a-zA-ZáàâäãåçéèêëíìîïñóòôöõúùûüýÿæœÁÀÂÄÃÅÇÉÈÊËÍÌÎÏÑÓÒÔÖÕÚÙÛÜÝŸÆŒ'-_]+|[^\s]+)/).map { |e| e[0] }

    louchebem_words.each do |word|
      louchebem_word = louchebemize_word(word)
      louchebem_word =~ /[a-zA-Z]/ ? louchebem_sentence << " " + louchebem_word : louchebem_sentence << louchebem_word
    end
    return louchebem_sentence.strip
  end

  private

  def self.louchebemize_cleaned_word(word)

    return word if word.size <= 2 || @stopwords.include?(word.downcase)
    return @know_words[word.downcase] if @know_words.key?(word.downcase)

    ary = word.chars
    vowel = %w(a e i o u y é è ê ë ô œ)
    suffix = SUFFIX.sample

    first_vowel_index = ary.index { |letter| vowel.include? letter }

    return word unless first_vowel_index

    rotated_word = ary.rotate(first_vowel_index).join

    "l#{rotated_word}#{suffix}"
  end

  def self.louchebemize_word(word)
    return @know_words[word.downcase] if @know_words.key?(word.downcase)

    is_cap = (word.capitalize == word)
    # split the word to remove trailling special caracters.
    # Currently this method is assuming that special caracters are at the end of the word
    words = word.split(/\s+|\b/)
    louchebem_word = ""
    words.each do |word|
      louchebem_word += louchebemize_cleaned_word(word)
    end
    louchebem_word = louchebem_word.capitalize if is_cap
    louchebem_word
  end


end

# p Louch.translate("Très d'objets!!")

# p Louch.translate("un chat c'est fou aujourd'hui!!")

# p Louch.translate("Uber à mis en ligne une liste d’objets «les plus singuliers» trouvés dans les voitures du réseau en Amérique du Nord.")
# p Louch.translate("Uber à mis en ligne une liste d'objets «les plus singuliers» trouvés dans les voitures du réseau en Amérique du Nord.")
