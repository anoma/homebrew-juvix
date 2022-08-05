# homebrew-juvix

Homebrew tap for installing the Juvix compiler

## Install

Run the following commands on your machine:

```
brew update
brew tap anoma/juvix
brew install juvix
```

## Formula testing

```
 brew audit --strict juvix
```

## Extra

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
