# homebrew-juvix
Homebrew tap for installing the Juvix compiler

## Install

```
brew tap anoma/juvix
brew install juvix
```

Remember to update your homebrew:

```
brew update
```

Testing the formula:

```
 brew audit --strict juvix
```

Make the bottle using the sources at `HEAD`:

```
brew update && brew install --build-bottle --HEAD juvix --verbose
```
