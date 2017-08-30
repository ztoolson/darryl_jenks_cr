require "../spec_helper"

describe DarrylJenksCr::Permutable do
  describe "#each_permutation" do
    it "send back permutations to 'hello world' with dashes" do
      test_class = DarrylJenksCr::Permutable.new("hello world")
      permutations = test_class.each_permutation(" ", "-")

      permutations.should contain("hello world")
      permutations.should contain("hello-world")
    end

    it "send back permutations to 'hello world' with dashes" do
      test_class = DarrylJenksCr::Permutable.new("hello world")
      permutations = test_class.each_permutation(" ", "-", {:non_replace_substitution => "R"})

      permutations.should contain("helloRworld")
      permutations.should contain("hello-world")
    end

    it "handles trailing permutable keys" do
      test_class = DarrylJenksCr::Permutable.new("hello ")
      permutations = test_class.each_permutation(" ", "-")

      permutations.should contain("hello ")
      permutations.should contain("hello-")
    end

    it "handles trailing permutable keys after multiple words" do
      test_class = DarrylJenksCr::Permutable.new("hello world ")
      permutations = test_class.each_permutation(" ", "-")

      permutations.should contain("hello world-")
      permutations.should contain("hello-world-")
      permutations.should contain("hello-world ")
      permutations.should_not contain("hello world")
    end
  end
end
