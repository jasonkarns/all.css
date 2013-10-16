initial.css
===========

Not quite a CSS reset or normalizer but resets all CSS *properties* to their `initial` value.

Here's the sitch:
You have a third party widget or are developing a widget or chrome extension that needs to operate in a CSS sandbox. You need to block any potential inheritance; which means you have to override the property's value. So you reset a bunch of key properties on your widget's container. But you need to also reset all the elements *within* your widget.
```css
#widget, #widget * {
  margin:0;
  padding:0;
  ...
}
```

So everything is working until your widget is dropped into a page that applies a `border-radius` to all `div`s. So you add `border-radius:0` to your reset. And that's when it dawns on you: you'll have to reset *every single CSS property* &ndash; all 300+ of them. :anguished:

In the future, you would use the [`all`](http://www.w3.org/TR/css3-cascade/#all-shorthand) property and the [`initial`](http://docs.webplatform.org/wiki/css/concepts/initial_value) value. But until then, you use [initial.css](/).

# Usage

Since initial.css resets *every* CSS property, you'll likely want it to only apply to your widget's containing element and below. You'll need to modify the selector as appropriate to your situation.

```css
#chrome-extension-xyz, #chome-extenstion-xyz * {
  align-content: initial;
  align-items: initial;
  align-self: initial;
}
```
