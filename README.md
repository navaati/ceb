ceb
===

Ceb is a software to generate static websites made of panels sliding in every direction. These panels can contain an audio track whose progress determine the display of list elements. The website is generated from a simple text-files based description.
The original purpose of this software was to make [a resumé](http://navaati.net/cv/) which you can take a look at, as an example of what can be produced.

It depends on `make`, `sass` (a CSS preprocessor written in ruby), `ffmpeg` and the basic UNIX tools.

Installing
----------

To install ceb, copy every file of it in `/usr/local/lib/ceb/`, except the `ceb` script itself which must be copied somewhere in your `PATH`, for example in `/usr/local/bin`.

Usage
-----

To use ceb, create a directory somewhere which will be the root of your site.

Each panel is called a section and is defined in its own subdirectory, which gives its name to the section.

Within this directory there must be a file named `color` containing the background color of the panel (in any CSS accepted format, like `#BEEFEE` or `rgb(200,255,200)`) on one line.
There must also be a file named `pos` containing the x and y position of the panel on one line. For example a panel two screen left and one screen down would have `-2 1` in its `pos` file.

A section can either be based on an audio track or on a custom xhtml.

- If it is audio-based its directory must contain an `audio.wav` file (which will be converted to webm and mp3) and a `lines` file. Each line of the `lines` file must start with a decimal number telling the time (in seconds) after which the rest of the line will appear.
- If the section is based on some custom html, it must be in the `custom` file. Be aware that what is in this file must be valid HTML5 in its XML serialization. Its content will be included in a `<section>` element.

Finally you must list, on one line, all sections in a `sections` file at the root of your site.
Then, run the `ceb` command and watch the magic happen... if nothing fails. A `build/` directory containing intermediate files will be created but most importantly the resulting site will be available, self-contained, in the `dist/` directory. At this point it can be copied straight to your web server.

As an example makes any documentation way clearer, you can see [the sources](http://navaati.net/cv/sources/) of the resumé I talked about.