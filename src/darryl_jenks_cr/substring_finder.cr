module DarrylJenksCr
  class SubstringFinder
    include Enumerable(String)

    property permutable_key, source_string

    def initialize(@permutable_key : (String | Regex), @source_string : String)
    end

    def each
      results = [] of String

      substring_indexes.each do |substring_index|
        results << source_string[substring_index..-1]
      end

      results
    end

    def each(&block)
      results = self.each
      results.each do |result|
        yield result
      end
    end

    def each_substring(permutable_key)
      @permutable_key = permutable_key

      self.to_a.to_enum
    end

    def each_substring(permutable_key, &block)
      @permutable_key = permutable_key

      results = self.each
      results.each do |result|
        yield result
      end
    end

    def substring_indexes
      start_index = -1
      string_length = source_string.size
      substring_indexes = [] of Int32

      while (start_index)
        break if start_index >= string_length
        substring_indexes << start_index if start_index > -1
        start_index = source_string.index(self.permutable_key, start_index + 1)
      end

      substring_indexes
    end

    def to_a
      self.each.to_a
    end
  end
end
