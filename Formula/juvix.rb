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
  
    
    def install
      system "make", "install"
    end
  
    # test do
    #   system "make", "test-shell"
    # end
  end
