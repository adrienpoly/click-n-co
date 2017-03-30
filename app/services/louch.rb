# Encoding: utf-8
# require_relative 'stopwords'
# p "I am loaded"
class Louch
SUFFIX = %w(em é ji oc ic uche ès).freeze
KNOWN_WORDS = { 'filou' => 'loufiat', 'boucher' => 'louchebem', 'aujourd\'hui' => 'laujourd\'huimuche' }.freeze
STOP_WORDS = [
  'alors',
  'au',
  'aucuns',
  'aussi',
  'autre',
  'avant',
  'avec',
  'avoir',
  'bon',
  'car',
  'ce',
  'cela',
  'ces',
  'ceux',
  'chaque',
  'c\'est',
  'ci',
  'comme',
  'comment',
  'dans',
  'des',
  'du',
  'dedans',
  'dehors',
  'depuis',
  'devrait',
  'doit',
  'donc',
  'dos',
  'début',
  'elle',
  'elles',
  'en',
  'encore',
  'essai',
  'est',
  'et',
  'eu',
  'fait',
  'faites',
  'fois',
  'font',
  'hors',
  'ici',
  'il',
  'ils',
  'je',
  'juste',
  'la',
  'le',
  'les',
  'leur',
  'là ',
  'ma',
  'maintenant',
  'mais',
  'mes',
  'mine',
  'moins',
  'mon',
  'mot',
  'même',
  'ni',
  'nommés',
  'notre',
  'nous',
  'ou',
  'où',
  'par',
  'parce',
  'pas',
  'peut',
  'peu',
  'plupart',
  'pour',
  'pourquoi',
  'quand',
  'que',
  'quel',
  'quelle',
  'quelles',
  'quels',
  'qui',
  'sa',
  'sans',
  'ses',
  'seulement',
  'si',
  'sien',
  'son',
  'sont',
  'sous',
  'soyez',
  'sujet',
  'sur',
  'ta',
  'tandis',
  'tellement',
  'tels',
  'tes',
  'ton',
  'tous',
  'tout',
  'trop',
  'très',
  'tu',
  'voient',
  'vont',
  'votre',
  'vous',
  'vu',
  'ça',
  'étaient',
  'état',
  'étions',
  'été',
  'être'
]

  def self.translate(sentence)
    # TODO: implement your louchebem translator
    louchebem_sentence = ""

    # louchebem_words = sentence.scan(/([a-zA-Z]+'?[a-zA-Z]+|[^\s]+)/).map { |e| e[0] }
    louchebem_words = sentence.scan(/([a-zA-Z]+'?\w+|[^\s]+)/).map { |e| e[0] }


    louchebem_words.each do |word|
      louchebem_word = louchebemize_word(word)
      louchebem_word =~ /[a-zA-Z]/ ? louchebem_sentence << " " + louchebem_word : louchebem_sentence << louchebem_word
    end
    # louchebem_words.join(' ')
    return louchebem_sentence.strip
  end

  private

  def self.louchebemize_cleaned_word(word)
    ary = word.chars
    vowel = %w(a e i o u y)
    suffix = SUFFIX.sample

    first_vowel_index = ary.index { |letter| vowel.include? letter }

    rotated_word = ary.rotate(first_vowel_index).join

    "l#{rotated_word}#{suffix}"
  end

  def self.louchebemize_word(word)
    # split the word to remove trailling special caracters.
    # Currently this method is assuming that special caracters are at the end of the word
    is_cap = (word.capitalize == word)
    words = word.split(/\s+|\b/)
    word = word.downcase
    # word = words.first
    # return word if word.gsub(/[^0-9A-Za-z]/, '').size <= 2
    return word if word.size <= 2 || STOP_WORDS.include?(word)
    return KNOWN_WORDS[word] if KNOWN_WORDS.key?(word)
    louchebem_word = louchebemize_cleaned_word(word)
    louchebem_word = louchebem_word.capitalize if is_cap
    # louchebemize_cleaned_word(word)
    # add special caracters where present initially
    return words.size == 1 ? louchebem_word : louchebem_word << words.last
  end

end

# p louchebemize("un chat c'est fou aujourd'hui!!")
