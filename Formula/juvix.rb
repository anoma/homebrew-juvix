class Juvix < Formula
  desc "The Juvix Compiler"
  homepage "https://github.com/anoma/juvix"
  version "0.6.10"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-x86_64.tar.gz"
      sha256 "a2340c298b00588f454e32a9590001ba1797f82b16f0e589e4fe4e9b3a155247"
    end
    on_arm do
      url "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-aarch64.tar.gz"
      sha256 "d2cfdc955218930305223487e4f014ce16b19e97d681b5a006f87ea304d9b016"
    end
  end

  def install
    bin.install "juvix"
  end
end
