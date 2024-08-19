#  Frosted Cookies

## A collection of minimal templates for projects in various languages/with various frameworks packaged with Nix.

Learning `nix` is tough, and part of this pain comes from trying to figure out how to package every different type of project you work on. Packaging `python` with `nix` is totally different from packaging `bun typescript` with `nix`, which is totally different from compiling and building `rust` or `c` with `nix`.

I've tried to gather and create various simple, understandable, and minimal project templates for all sorts of different types of projects, and have bundled them together here.


All of these templates are designed for use with [Cookiecutter](https://github.com/cookiecutter/cookiecutter), and are properly `nix`ified so that you can just run `cookiecutter gh:404wolf/project-templates --directory <template>`, and then `nix develop`.

## Usage

You can use these templates in two different ways.

### Nix App

Firstly, this is a `nix` "app", so you can literally just run 

```bash
nix run github:404wolf/frosted-cookies
```

to view the template options, and then

```bash
nix run github:404wolf/frosted-cookies -- <template>
```

To use one. Since this is a `nix` "app", it'll fetch and run `cookiecutter` too, so you don't need to install or set anything up! `nix` is so cool!

---

Alternatively, you can just use `cookiecutter`'s github source to use a template. It looks something like this.

```bash
cookiecutter gh:404wolf/project-templates --directory <template>
```

Where `<template>` is one of the directories in this repository.

## Templates

Currently available templates:

* `trivial`: Just a flake. Includes a `devShell` with packages and nothing more.
* `nixos`: An entire operating system declaration in like, 15 lines of code. (a nix flake).
* `java`: `maven` project that uses the `nix` `buildMavenPackage` utility. Includes all your favorite `java` boilerplate, and no more.
* `latex`: Simple `latex` project using a custom `buildLatexDocument` helper utility.
* `python-poetry`: A proper `python` package built with poetry.
* `python-scripting`: Extremely minimal `python` project that is just a script.
* `rust`: Basic `rust` project layout built with `nix` using `buildRustPackage`. This is a work in progress!
* `ts-bun`: A `bun` project that has bundling and a single entry point. Uses a `fixed-point` derivation for now.
* `ts-node`: A `node` project that has bundling with `esbuild` and a single entry point. Uses the `buildNpmPackage` utility for buildling.

