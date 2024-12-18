class JuvixNightly < Formula
  desc "The Juvix Compiler Nightly Build"
  homepage "https://github.com/anoma/juvix-nightly"
  version "0.6.8-af19142"

  on_macos do
    on_intel do
      url  "https://github.com/anoma/juvix-nightly-builds/releases/download/nightly-2024-12-18-0.6.8-af19142/juvix-darwin-x86_64.tar.gz"
      sha256 "91a23ab9d77fe2fd05abf75cb9640b80a13549d76e8b2ad123882e1266cc27e2"
    end
    on_arm do
      url "https://github.com/anoma/juvix-nightly-builds/releases/download/nightly-2024-12-18-0.6.8-af19142/juvix-darwin-aarch64.tar.gz"
      sha256 "6f24daf108ab805f5722ad9c0da88b3f432c842dd5dc13eb7308babb60873576"
    end
  end

  def install
    bin.install "juvix"
  end
end
