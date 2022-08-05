# homebrew-juvix

Homebrew tap for installing the Juvix compiler

## Install

Run the following commands on your machine:

```
brew update
brew tap anoma/juvix
brew install juvix
```

If you want to build Juvix from the sources and see what's exactly is going on, run:

```
brew install --build-from-source juvix --verbose
```

## Extra

Homebrew provides the following way to audit a formula. Let's
use it against Juvix.

```
 brew audit --strict juvix
```

If you want to make a Juvix bottle using the sources, run the following command:

```
brew install --build-bottle --HEAD juvix
```

## Removing Juvix

To uninstall Juvix using homebrew, run the command:

``` 
brew uninstall juvix
``` 

If you want to uninstall the formula as well, untap it by running:

```
brew untap anoma/juvix
```

The Juvix Homebrew formula was created following the guideline:

- https://docs.brew.sh/Formula-Cookbook
