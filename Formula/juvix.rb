# coding: utf-8
class Juvix < Formula
    desc "The Juvix compiler"
    homepage "https://juvix.org"
    url "https://github.com/anoma/juvix.git", branch: "main"
    license "AGPL-3.0-or-later"

    # This version must match the GHC version used by the stack resolver in the Juvix project
    @@ghc_version = "9.4.5"
    
    stable do
      url "https://github.com/anoma/juvix.git",
          using:    :git,
          revision: "9f8c26dbb25ee76d1c9a9b7033c0b7118b2e3088"
      version "0.5.5"
    end

    head do
      url "https://github.com/anoma/juvix.git", branch: "main"
    end

    livecheck do
      skip "No version information available to check"
    end
  
    option "without-stack", "Do not install Haskell-Stack"
    
    depends_on "make" => :build
    depends_on "xz" => :build
    depends_on "llvm" => :build
    depends_on "stack" => :build
  
    # bottle do
    #   root_url "https://github.com/anoma/juvix/releases/download/v0.5.4"
    #   sha256 cellar: :any_skip_relocation, arm64_ventura: "52d09f8d45eef577500c279b43a7bfa4edc426ad55e3ffb2b75e3cbf85971994"
    #   sha256 cellar: :any_skip_relocation, ventura: "01d3b875e0212c876df4935106266f8f8986b38c9399d5a1199413de63685556"
    # end

    def get_system_architecture
      require 'rbconfig'
      RbConfig::CONFIG['host_cpu']
    end

    def install
      require "tmpdir"
      jobs = ENV.make_jobs
      opts = [ "--stack-root", buildpath/".stack" ]
      # The runtime build must use the homebrew LLVM installation, not the one provided by macOS.
      system "make", "runtime", "CC=#{Formula["llvm"].opt_bin}/clang", "LIBTOOL=#{Formula["llvm"].opt_bin}/llvm-ar"
      arch = get_system_architecture
      ghc_basename = "ghc-#{@@ghc_version}-#{arch}-apple-darwin"
      ghc_archive_name = "#{ghc_basename}.tar.xz"

      ghc_root = Dir.mktmpdir
      begin
        ENV.prepend_path "PATH", "#{ghc_root}/bin"
        with_env(
          "LD" => "ld",
        ) do
          # We install GHC using the binary release directly because installation of GHC via ghcup
          # or via stack in the formula context is not reliable.
          system "curl", "-OL", "https://downloads.haskell.org/~ghc/#{@@ghc_version}/#{ghc_archive_name}"
          system "tar", "xf", "#{ghc_archive_name}"
          Dir.chdir("#{ghc_basename}") do
            system "./configure", "--prefix=#{ghc_root}"
            system "make", "install"
          end
          system "stack", "--system-ghc", "--no-install-ghc", "-j#{jobs}", "--local-bin-path=#{bin}", "install", *opts
        end
        share.install Dir["juvix-mode/*"]
        share.install Dir["examples/*"]
      ensure
        FileUtils.remove_entry(ghc_root) if ghc_root
      end
    end

    def caveats
      <<~EOS
        =============================== Juvix examples =================================
        To see all the Juvix example files, check out the path:

          #{share}/milestone

        There, you might want to typecheck a Juvix file. For example, run:
        
          juvix typecheck Fibonacci/Fibonacci.juvix

        ============================ Juvix mode for Emacs ==============================
        To install the Juvix mode in Emacs, please add the following lines to the
        configuration file (often at "~/.emacs.d").
          
          (push "#{share}" load-path)
              (require 'juvix-mode)
            
        Restart Emacs for the change to take effect. Open Emacs again and the Juvix mode
        will be activated automatically for files with extension ".juvix".
        
        To typecheck a Juvix file using the keybinding, press "Ctrl-c + Ctrl-l".
        
        In case you're missing Emacs, we recommend you to install it as follows on MacOS:

          brew tap d12frosted/emacs-plus
          brew install emacs-plus@28

        ============================= Juvix VSCode =====================================

        You can find the Juvix-Mode plugin in the VSCode marketplace. Alternatively, you
        can run the following command on your shell:

          ext install heliax.juvix-mode
        
        ====================== Install the auto-completion Scripts =====================
        To get the Juvix CLI completions for your shell, run the following:

        * Bash
          juvix --bash-completion-script juvix > ~/.bashrc
        
        * FISH
          juvix --fish-completion-script juvix > ~/.config/fish/completions/juvix.fish
        
        * ZSH 
          juvix --zsh-completion-script juvix > $DIR_IN_FPATH/_juvix
        
        The variable $DIR_IN_FPATH is a directory that is present on the ZSH FPATH
        variable (which you can inspect by running `echo $FPATH` in the shell).
        
        Restart your terminal for the settings to take effect.
        
        ======================== Compile Juvix programs to Wasm ========================  
        To compile Juvix to Wasm, please follow the instructions on the website.
        The requirement are: wasmer, Clang/LLVM, wasi-sdk, and wasm-ld.
        
        https://docs.juvix.org/latest/howto/installing/
        
        ============================ Getting more help =================================
        To see all the Juvix commands, run:
          juvix --help

        To check your setup, run:
          juvix doctor

        For more documentation, please check out the Juvix Book website:
          https://docs.juvix.org

        or the Github repository:
          https://github.com/anoma/juvix

        To see these instructions, run:
          brew info juvix
      EOS
    end

    test do
      stdlibtest = testpath/"Fibonacci.juvix"
      stdlibtest.write <<~EOS
      module Fibonacci;

      open import Stdlib.Prelude;

      fib : Nat → Nat → Nat → Nat;
      fib zero x1 _ := x1;
      fib (suc n) x1 x2 := fib n x2 (x1 + x2);

      fibonacci : Nat → Nat;
      fibonacci n := fib n 0 1;

      main : IO;
      main := readLn (printNatLn ∘ fibonacci ∘ stringToNat);

      EOS
  
      assert_equal "Well done! It type checks\n", shell_output("#{bin}/juvix typecheck #{stdlibtest}")
      # system bin/"juvix", "compile", stdlibtest
      # assert_equal "75025" , shell_output("wasmer  #{testpath}/Fibonacci.wasm")
    end

  end
