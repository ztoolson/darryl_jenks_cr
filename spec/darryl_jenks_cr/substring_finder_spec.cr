require "../spec_helper"

describe DarrylJenksCr::SubstringFinder do
  describe "#substring_indexes" do
    it "returns an empty array when no occurrences are present" do
      test_class = DarrylJenksCr::SubstringFinder.new(" ", "hello")
      test_class.substring_indexes.should eq([] of Int32)
    end

    it "returns a single entry when word boundary on single word" do
      test_class = DarrylJenksCr::SubstringFinder.new(/\b/, "hello")
      test_class.substring_indexes.should eq([0])
    end

    it "returns 3 entries when word boundary on 2 words" do
      test_class = DarrylJenksCr::SubstringFinder.new(/\b/, "hello world")
      test_class.substring_indexes.should eq([0, 5, 6])
    end

    it "returns 2 entries when 'l' in 'hello'" do
      test_class = DarrylJenksCr::SubstringFinder.new("l", "hello")
      test_class.substring_indexes.should eq([2, 3])
    end
  end

  describe "#to_a" do
    it "returns the substring splits of word boundaries" do
      test_class = DarrylJenksCr::SubstringFinder.new(/\b/, "hello world")
      test_class.to_a.should eq(["hello world", " world", "world"])
    end

    it "returns an empty array when no occurrences are present" do
      test_class = DarrylJenksCr::SubstringFinder.new(" ", "hello")
      test_class.to_a.should eq([] of String)
    end

    it "returns 2 entires when 'l' in 'hello'" do
      test_class = DarrylJenksCr::SubstringFinder.new("l", "hello")
      test_class.to_a.should eq(["llo", "lo"])
    end
  end
end
