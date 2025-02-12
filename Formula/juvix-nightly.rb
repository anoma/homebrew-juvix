class JuvixNightly < Formula
  desc "The Juvix Compiler Nightly Build"
  homepage "https://github.com/anoma/juvix-nightly"

  juvix_version = "0.6.9-6ff4d88"
  version juvix_version

  nightly_tag = "nightly-2025-01-23-#{juvix_version}"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-x86_64.tar.gz"
      sha256 "b5d5466430491547f34399e3e430d150675caff7ec4976bcf11a58e48c460d7e"
    end
    on_arm do
      url "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-aarch64.tar.gz"
      sha256 "8e50abe026662134ffb1a0a417d171f93509635d7b08980006ff2a789e20cd7d"
    end
  end

  def install
    bin.install "juvix"
  end
end
