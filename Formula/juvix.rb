class Juvix < Formula
  desc "The Juvix Compiler"
  homepage "https://github.com/anoma/juvix"
  version "0.6.9"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-x86_64.tar.gz"
      sha256 "050e606f24ff6aeaa098bcb5223dcb92298279388aa93839acb7c5398d24a50e"
    end
    on_arm do
      url "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-aarch64.tar.gz"
      sha256 "ba9917d0af6b05cde17b4a160dd2e1476fe6ad4364ad35d0b71cbde973ddd2ae"
    end
  end

  def install
    bin.install "juvix"
  end
end
