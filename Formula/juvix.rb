class Juvix < Formula
  desc "The Juvix Compiler"
  homepage "https://github.com/anoma/juvix"
  version "0.6.10"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-x86_64.tar.gz"
      sha256 "6544d3d1dd9705287ae087dd4467fe48671d7c3b2b4da876c23c3d07aedf3114"
    end
    on_arm do
      url "https://github.com/anoma/juvix/releases/download/v#{version}/juvix-macos-aarch64.tar.gz"
      sha256 "e5385b6d4da75ac4b30507cf2dbeafdef37e269227d871b991aa7a4e63abf5a9"
    end
  end

  def install
    bin.install "juvix"
  end
end
