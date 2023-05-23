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

## Release

To update after a Juvix release:

1. Update the `version` and `sha256` fields of the `stable` block in the formula and push.
2. Run `brew update`, `brew install --build-bottle juvix`, and `brew bottle juvix` to build the bottle for the release.
3. Upload the bottle TAR file to the Juvix release artifacts. (NB: rename the TAR to match the naming scheme).
4. Update the bottle block with details obtained from step 2 and push.
5. Test that you can install Juvix using the bottle, `brew update`, `brew install juvix`, and `juvix --version`.

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
