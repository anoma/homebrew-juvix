class Juvix < Formula
    desc "The Juvix compiler"
    homepage "https://juvix.org"
    url "https://github.com/anoma/juvix.git", branch: "main"
    license "AGPL-3.0-or-later"
    
    stable do
      url "https://github.com/anoma/juvix.git", branch: "main"
      version "0.2.2"
      sha256 "6c4cff2655c2f13d0770c40e5473b03f25cc049edc73b4f3c4458013032f70ec"
    end
    
    head do
      url "https://github.com/anoma/juvix.git", branch: "main"
    end
  
    # option "with-emacs", "Install Emacs Plus v28"
    option "without-stack", "Do not install Haskell-Stack"
    
    depends_on "make" => :build
    depends_on "llvm" => :build
    depends_on "stack" => :build
    # depends_on "d12frosted/emacs-plus/emacs-plus@28" => :optional
  
    bottle do
      rebuild 1
      sha256 cellar: :any_skip_relocation, monterey: "bfb13754cc4ccacadb9917a772fe7fb6e6ba6d0364c75d57520ccd68980f8e58"
    end
    
    def install
      jobs = ENV.make_jobs
      # Let `stack` parallelize
      ENV.deparallelize { system "stack", "-j#{jobs}", "setup", "9.2.3", "--stack-root", buildpath/".stack" }
      ENV.prepend_path "PATH", Dir[buildpath/".stack/programs/*/ghc-*/bin"].first
      ghc_args = [
        "--system-ghc",
        "--no-install-ghc",
        "--skip-ghc-check",
      ]
      system "stack", "-j#{jobs}", "build", *ghc_args
      system "stack", "-j#{jobs}", "--local-bin-path=#{bin}", "install", *ghc_args
    end

  end
