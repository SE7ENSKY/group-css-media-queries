group-css-media-queries
=======================

CSS postprocessing: group media queries. Useful for postprocessing preprocessed CSS files.

# What is it?

You have input.css (take note on similar media query):
```css
.header-main {
  background-image: url("/images/branding/logo.main.png");
}
@media all and (min-device-pixel-ratio:1.5),(min-resolution:138dpi),(min-resolution:1.5dppx) {
  .header-main {
    background-image: url("/images/branding/logo.main@2x.png");
    -webkit-background-size: auto auto;
    -moz-background-size: auto auto;
    background-size: auto auto;
  }
}
.footer-main {
  background-image: url("/images/branding/logo.main.png");
}
@media all and (min-device-pixel-ratio:1.5),(min-resolution:138dpi),(min-resolution:1.5dppx) {
  .footer-main {
    background-image: url("/images/branding/logo.main@2x.png");
    -webkit-background-size: auto auto;
    -moz-background-size: auto auto;
    background-size: auto auto;
  }
}
```

Run this utility:
```
group-css-media-queries input.css output.css
```

The result is output.css:
```css
.header-main {
  background-image: url("/images/branding/logo.main.png");
}

.footer-main {
  background-image: url("/images/branding/logo.main.png");
}

@media all and (-webkit-min-device-pixel-ratio:1.5),(min--moz-device-pixel-ratio:1.5),(-o-min-device-pixel-ratio:1.5/1),(min-device-pixel-ratio:1.5),(min-resolution:138dpi),(min-resolution:1.5dppx) {
  .header-main {
    background-image: url("/images/branding/logo.main@2x.png");
    -webkit-background-size: auto auto;
    -moz-background-size: auto auto;
    background-size: auto auto;
  }

  .footer-main {
    background-image: url("/images/branding/logo.main@2x.png");
    -webkit-background-size: auto auto;
    -moz-background-size: auto auto;
    background-size: auto auto;
  }
}
```

Split in different files:

```
group-css-media-queries -s input.css
```

Result is:

```
Creating app-splitted/app-root.css
Creating app-splitted/app-all-and-(min-device-pixel-ratio:1.5)(min-resolution:138dpi)(min-resolution:1.5dppx).css
```

Split in different files in a custom directory:

```
group-css-media-queries -s input.css -d custom-dir
```

Result is:

```
Creating custom-dir/app-root.css
Creating custom-dir/app-all-and-(min-device-pixel-ratio:1.5)(min-resolution:138dpi)(min-resolution:1.5dppx).css
```


Voila!

# Installing

```
npm install -g group-css-media-queries
```
