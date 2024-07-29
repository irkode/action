# _Bulma 4 Hugo_ - Use Bulma easily within your Hugo site

Bulma releases packaged for use with Hugo as module or using git.

## Features

- access to all build variants from Bulma release.
- choose a precompiled CSS variant
- use the SCSS and your build pipeline
  - customize SCSS if you want
- easy version change depending on your chosen usage

## Disclaimer

This is just a brute force repacking Bulma release for using as a Hugo module.
- There's no stuff like verification and testing. 
- delivered as-is, no guarantee no warranty
- No Bulma support here

## Support

If you have problems/issues with Bulma itself, please use [Bulma issue tracker](https://github.com/jgthms/bulma/issues).

anything regarding the packaging may be addressed here [Bulma 4 Hugo](https://github.com/irkode/bulma4hugo)

## Use Bulma 4 Hugo in your Hugo project

Set up a you Hugo site and change to its site root folder.

Add _Bulma 4 Hugo_ to your site using one of the below methods

### Hugo module (preferred)

- First [install Go](https://go.dev/doc/install) (needed for hugo modules)

- add the module to your site config file:

  - hugo.yaml

    ```yaml
    module:
      imports:
        - path: github.com/irkode/bulma4hugo
    ```

  - hugo.toml

    ```toml
    [module]
      [module.imports]
        path = github.com/irkode/bulma4hugo
    ```

### Git

In your site root folder choose the method you want

- Clone

  ```
  git clone https://github.com/irkode/bulma4hugo.git themes/bulma4hugo
  ```

- Submodule

  ```
  git submodule add https://github.com/irkode/bulma4hugo.git themes/bulma4hugo
  ```

Add the Theme to your site configuration

- hugo.yaml

  ```yaml
  theme: bulma4hugo
  # use array syntax if you need other themes, too
  theme:
    - bulma4hugo
    - othertheme
    ...
  ```

- hugo.toml

  ```toml
  theme = "bulma4hugo"
  # use array syntax if you need other themes, too
  theme = ["bulma4hugo", "othertheme", ...]
  ```

## Use Bulma

The files are stored in Hugo `/assets` folder. Available variants depend on Bulma release version.

## Version and Update

_Bulma 4 Hugo_ follows the Bulma release scheme. So version numbers are same.

Only tagged releases are available.

We automatically pack new versions of Bulma shortly after release.

## Included Files
