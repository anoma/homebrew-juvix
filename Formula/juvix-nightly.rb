class JuvixNightly < Formula
  desc "The Juvix Compiler Nightly Build"
  homepage "https://github.com/anoma/juvix-nightly"

  juvix_version = "0.6.10-682a6fa"
  version juvix_version

  nightly_tag = "nightly-2025-05-06-#{juvix_version}"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-x86_64.tar.gz"
      sha256 "35f1ce5035816b21693df667259a646d870efa797796a298ba6f724908c6b966"
    end
    on_arm do
      url "https://github.com/anoma/juvix-nightly-builds/releases/download/#{nightly_tag}/juvix-darwin-aarch64.tar.gz"
      sha256 "15689f73914dd1893e735910c666bcfd17db8dc76a14d66ba2ff7a8e42ec9e99"
    end
  end

  def install
    bin.install "juvix"
  end
end
