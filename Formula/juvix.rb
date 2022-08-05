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

    livecheck do
      skip "No version information available to check"
    end
  
    option "without-stack", "Do not install Haskell-Stack"
    
    depends_on "make" => :build
    depends_on "llvm" => :build
    depends_on "stack" => :build
  
    bottle do
      root_url "https://github.com/anoma/juvix/releases/download/v0.2.2"
      sha256 cellar: :any_skip_relocation, arm64_monterey: "56da70e13fcfc70f180b1a999a80a19be779d589d28d06d99390e08bc53eede4"
      sha256 cellar: :any_skip_relocation, x86_64_monterey: "bfb13754cc4ccacadb9917a772fe7fb6e6ba6d0364c75d57520ccd68980f8e58"
    end
    
    def install
      jobs = ENV.make_jobs
      opts = [ "--stack-root", buildpath/".stack" ]
      ENV.deparallelize { system "stack", "-j#{jobs}", "setup", "9.2.3", *opts }
      ENV.prepend_path "PATH", Dir[buildpath/".stack/programs/*/ghc-*/bin"].first
      system "stack", "-j#{jobs}", "build" , *opts
      system "stack", "-j#{jobs}", "--local-bin-path=#{bin}", "install"  , *opts

      bin.install Dir["juvix-mode"]
    end

    def caveats
      # maybe use #{HOMEBREW_PREFIX}/share/autojump
      <<~EOS
        == Install the Juvix mode for Emacs text editor ================================   
        Add the following lines to your Emacs configuration file:

          (push "#{HOMEBREW_PREFIX}/share/juvix/juvix-mode/" load-path)
          (require 'juvix-mode)
        
        The Juvix mode will be activated automatically for files of extension ".juvix".
        To typecheck a Juvix file use the keybinding: "Ctrl c + Ctrl l".

        == Install the auto-completion Scripts =========================================
        Run the following command to get Juvix CLI completions for your shell.

          * Bash:
            juvix --bash-completion-script juvix > ~/.bashrc
          
          * FISH
            juvix --fish-completion-script juvix > ~/.config/fish/completions/juvix.fish
          
          * ZSH 
            juvix --zsh-completion-script juvix > $DIR_IN_FPATH/_juvix
          
            where $DIR_IN_FPATH is a directory that is present on the ZSH FPATH
            variable (which you can inspect by running `echo $FPATH` in the shell).

        Restart your terminal for the settings to take effect.

        For see all the juvix commands, run:

          juvix --help

        For more documentation, please checkout the Juvix Book website:
          https://docs.juvix.org
      EOS
    end

    test do
      stdlibtest = testpath/"Fibonacci.agda"
      stdlibtest.write <<~EOS
      module Fibonacci;
      
      open import Stdlib.Prelude;
      
      fib : ℕ → ℕ → ℕ → ℕ;
      fib zero x1 _ ≔ x1;
      fib (suc n) x1 x2 ≔ fib n x2 (x1 + x2);
      
      fibonacci : ℕ → ℕ;
      fibonacci n ≔ fib n 0 1;

      main : IO;
      main ≔ putStrLn (natToStr (fibonacci 25));
      end;
      EOS
  
      assert_equal "Well done! It type checks\n", shell_output("#{bin}/juvix typecheck #{stdlibtest}")
      # system bin/"juvix", "compile", stdlibtest
      # assert_equal "75025" , shell_output("wasmer  #{testpath}/Fibonacci.wasm")
    end

  end
