--- 
title: Encoding utilities
date: 04/08/2011
author: Kiyoshi Murata
layout: post
comments: true
categories: util encoding
--- 

Very short post, just a tip on encoding/charset utilities to use with files.

## [iconv](http://www.gnu.org/s/libiconv/)

The holy grail of encoding, if you didn't know it before, just follow the link
on the title and read about it. Every other thing in universe uses it to
perform encoding conversion.

## [detox](http://detox.sourceforge.net)

This one is my favorite, it will rename files and make them "safe" (this pretty
much depends on the filesystem you're using. You put a unicode char in a
filename on a FAT32 partition and the universe collapses in a singularity).
It supports sequences of filters that you can create and pass the filenames
through. Very handy.

## [convmv](http://www.j3e.de/linux/convmv)

_[man page](http://www.j3e.de/linux/convmv/man/)_

convmv also renames files, but deals specifically with encoding, so it's more
powerful and supports a wide range of encodings, very good too.

## recode

_I couldn't find its home page, Debian package is "recode"_

"recode converts files between character sets and usages." It supports
sequences like detox, is powerful but a little cumbersome. Note that it
converts file contents, not filenames.

## [uni2ascii](http://billposer.org/Software/uni2ascii.html)

Converts file contents from unicode to ascii-encoded formats, like HTML
encoding. Very nice to put in source code, pages, etc.

## [dos2unix](http://waterlan.home.xs4all.nl/dos2unix.html)

Not exactly an encoding utility, but useful to get rid of `\r\n` in files
created on lesser OSes.
