--- 
title: Compiling Ruby on Debian testing/wheezy with no SSL2
date: 21/06/2011
author: Kiyoshi Murata
layout: post
comments: true
categories: debian ruby
--- 

_**Update**: [Ruby 1.9.2-p290](http://www.ruby-lang.org/en/news/2011/07/15/ruby-1-9-2-p290-is-released) and [Ruby 1.8.7-p352](http://www.ruby-lang.org/en/news/2011/07/02/ruby-1-8-7-p352-released/) fixes the issue in this post._

Debian openssl package now ships [without SSL2
support](http://packages.debian.org/changelogs/pool/main/o/openssl/current/changelog#version1.0.0c-2),
but it was only in experimental/unstable until 1.0.0d was [migrated to
testing](http://packages.qa.debian.org/o/openssl/news/20110409T163912Z.html)
that things got messed up for me, since I use testing and Ruby (both 1.8.7 and
1.9.2) have problems ([1][nossl2_backport87] and [2][nossl2_backport92])
compiling against a nossl2'ed OpenSSL lib.

[nossl2_backport87]: http://redmine.ruby-lang.org/issues/4860
[nossl2_backport92]: http://redmine.ruby-lang.org/issues/4861

While these problems are not fixed (the fix is in trunk, but not backported to
1.8 or 1.9 branches), I fetched the patches from the [actual
fix](http://redmine.ruby-lang.org/issues/4556), formatted them and compiled the
rubies with them.

Patches are:

* [Ruby 1.8.7](https://gist.github.com/1039377#file_ruby_1.8.7_nossl2.diff)
* [Ruby 1.9.2](https://gist.github.com/1039377#file_ruby_1.9.2_nossl2.diff)

And you can compile Ruby either applying them manually over the source tree
with level 1 (`patch -p1 < ruby187.patch`) or if you use
[rvm](http://rvm.beginrescueend.com) (which is very likely), you can use custom
patches when installing rubies. It is explained in rvm's docs at
<https://rvm.beginrescueend.com/rubies/patching/>. It is simple as doing:

{% codeblock lang:sh %}
rvm install 1.8.7 --patch /path/to/ruby187.patch
{% endcodeblock %}

Now Ruby happily compiles on my Debian testing :)
