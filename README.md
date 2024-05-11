# Solarized and Selenized for VS Code

This extension contains the following color themes and variants:

* Selenized Light
* Selenized Dark
* Selenized White (TODO)
* Selenized Black (TODO)
* Solarized Light (TODO)
* Solarized Dark (TODO)

## Screenshots

### Workbench (UI)

![Selenized Light workbench screenshot](assets/screenshot-workbench-selenized-light.png "Selenized Light workbench")

![Selenized Dark workbench screenshot](assets/screenshot-workbench-selenized-dark.png "Selenized Dark workbench")

### Editor

![Selenized Light editor screenshot](assets/screenshot-editor-selenized-light.png "Selenized Light editor")

![Selenized Dark editor screenshot](assets/screenshot-editor-selenized-dark.png "Selenized Dark editor")

## Templatized color theme files

Maintaining loose vscode color theme extension JSON files with raw sRGB values
is tedious. So, I broke them up into shareable components as Liquid template
partials.

Let's take a look at a top-level [`Selenized Light-color-theme.json.liquid`][1]
file, for instance. This file compiles to the unwieldy vscode color theme file
[`Selenized Light-color-theme.json`][2]. However, the "source" template itself
is quite simple:

```liquid
{% render
  "_selenized-color-theme.json.liquid",
    type: "light",
    colors: palette.colors,
-%}
```

Where [`_selenized-color-theme.json.liquid`][3] is a Selenized color theme
template that can be instantiated in dark or light variant with the injected
variable `type`.

Taking this idea further, the content of *that* template is further broken down
into its constituents parts: **Workbench (UI)** colors, **TextMate token**
(fallback) colors, and **semantic syntax token** (LSP-provided) colors.

```liquid
{%- assign colors = colors | map: "srgb_hex" -%}

{
  "name": "Selenized {{ type | capitalize }}",
  "type": "{{ type }}",

  // Workbench (UI) colors
  "colors": {% render
    "workbench-colors.json.liquid",
    type: type,
    base00: colors[0],
    base01: colors[1],
    base02: colors[2],
    base03: colors[3],
    base04: colors[4],
    base05: colors[5],
    base06: colors[6],
    base07: colors[7],
    base08: colors[8],
    base09: colors[9],
    base0a: colors[10],
    base0b: colors[11],
    base0c: colors[12],
    base0d: colors[13],
    base0e: colors[14],
    base0f: colors[15],
  %},

  // TextMate scoped token highlight colors (fallback)
  "tokenColors": {% render
    "token-colors.json.liquid",
    base00: colors[0],
    base01: colors[1],
    base02: colors[2],
    base03: colors[3],
    base04: colors[4],
    base05: colors[5],
    base06: colors[6],
    base07: colors[7],
    base08: colors[8],
    base09: colors[9],
    base0a: colors[10],
    base0b: colors[11],
    base0c: colors[12],
    base0d: colors[13],
    base0e: colors[14],
    base0f: colors[15],
  %},

  // Semantic token (LSP-provided) colors
  "semanticHighlighting": true,
  "semanticTokenColors": {% render
    "semantic-token-colors.json.liquid",
    base00: colors[0],
    base01: colors[1],
    base02: colors[2],
    base03: colors[3],
    base04: colors[4],
    base05: colors[5],
    base06: colors[6],
    base07: colors[7],
    base08: colors[8],
    base09: colors[9],
    base0a: colors[10],
    base0b: colors[11],
    base0c: colors[12],
    base0d: colors[13],
    base0e: colors[14],
    base0f: colors[15],
  %}
}
```

As you can see, each component template is injected with theme-agnostic base
color names. There are 16 of them and they roughly follow the [Base16][4] color
theming framework.

What this means is that `colors`, `tokenColors`, and `semanticTokenColors` can
now be expressed in terms of color variable names that are independent of the
target color theme. For example:

```liquid
{%- assign fg_0 =     base04 %}
{%- assign orange =   base09 %}

...

  {
    "name": "Language Constants",
    "scope": [
      "constant.language",
      "support.constant",
      "variable.language"
    ],
    "settings": {
      "foreground": "#{{ orange }}"
    }
  },
  {
    "name": "Variables",
    "scope": [
      "variable",
      "variable.parameter",
      "support.variable"
    ],
    "settings": {
      "foreground": "#{{ fg_0 }}"
    }
  },
```

This also keeps things DRY. The same template files are shared between Selenized
Light, Selenized Dark, Solarized Light, and Solarized Dark--the four
colorschemes that are defined in this repository.

Indeed, these three components are defined as three template partials files
in a [`common/`][5] directory.

## Palette for color values injection

The templates (and the shared components partials that they instantiate) are
injected with color values that are derived from one of the [palette files][6].
Each of them is defined as a yaml file that contains 16 colors (per Base16
convention).

Each color in a palette has a name and index in an array. Its canonical values
are in CIE L\*a\*b\* colorspace. The palette file must first be processed to
convert those values into sRGB, and then into Liquid objects before they can
be injected into the templates for rendering the final vscode JSON files.

## For more information

* [Theme Color][7]
* [Visual Studio Code extension guide: Color Theme][8]
* [Semantic coloring in Color Themes][9]

[1]: themes/selenized/light-color-theme.json.liquid
[2]: <themes/Selenized Light-color-theme.json>
[3]: themes/selenized/_selenized-color-theme.json.liquid
[4]: https://github.com/chriskempson/base16/blob/main/styling.md
[5]: themes/common
[6]: palettes
[7]: https://code.visualstudio.com/api/references/theme-color
[8]: https://code.visualstudio.com/api/extension-guides/color-theme
[9]: https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide#semantic-coloring-in-color-themes
