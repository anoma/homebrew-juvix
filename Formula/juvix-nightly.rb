class JuvixNightly < Formula
  desc "The Juvix Compiler Nightly Build"
  homepage "https://github.com/anoma/juvix-nightly"

  juvix_version = "0.6.9-8b06157"
  version juvix_version

  nightly_tag = "nightly-2025-02-13-#{juvix_version}"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-x86_64.tar.gz"
      sha256 "d3ed5c3ea5708e9d910d6de184be0fb0b09d40c7dde776e7a86091fae97971db"
    end
    on_arm do
      url "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-aarch64.tar.gz"
      sha256 "dc0b0307b0cd86bc6e825eea794a8d9f9b62f4591d9aa916feddfb740a9f66c7"
    end
  end

  def install
    bin.install "juvix"
  end
end
