module DarrylJenksCr
  class Permutable
    property key

    def initialize(@key : String)
    end

    ##
    # Computes the Permutations of a string
    #
    # Ex: key_string = "HELLO WORLD FIRST"
    #
    # each_permutation(" ", "-")
    # dash_permutations = [ "HELLO-WORLD FIRST", "HELLO-WORLD-FIRST", "HELLO WORLD-FIRST" ]
    #
    # The 'permutable_key' is the character/regex that should be used as the split mechanism
    # to determine how many objects are in the collection to be "permed"
    #
    # The 'substitution_value' is the character that should be used in the permutations of
    # the string as the separator value
    #
    def each_permutation(permutable_key, substitution_value, options = {} of Symbol => String)
      return [] of String unless self.key.index(permutable_key)

      permutations = [] of String
      split_tokens = self.key.split(permutable_key)
      # At least a single permutation needs to be present
      number_of_permutations = [(split_tokens.size - 1), 1].max

      permutations_for(number_of_permutations).each do |permutation_pattern|
        permutation_string = ""
        copied_tokens = split_tokens.map { |token| token.dup }

        permutation_pattern.each do |replace_split_token|
          permutation_string += copied_tokens.shift

          if replace_split_token
            permutation_string += substitution_value
          else
            permutation_string += (options[:non_replace_substitution]? || permutable_key)
          end
        end

        permutation_string += copied_tokens.shift unless copied_tokens.empty?
        permutations << permutation_string
      end

      permutations
    end

    def each_permutation(permutable_key, substitution_value, options = {} of Symbol => String, &block)
      permutations = self.each_permutation(permutable_key, substitution_value, options)

      permutations.each do |permutation|
        yield permutation
      end
    end

    private def permutations(permutable_key, substitution_value, options = {} of Symbol => String)
    end

    def permutations_for(size_of_tokens)
      [true, false].repeated_permutations(size_of_tokens).to_a
    end
  end
end
