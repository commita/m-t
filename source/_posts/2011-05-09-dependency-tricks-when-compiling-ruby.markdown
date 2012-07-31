---
layout: post
title: "Dependency tricks when compiling Ruby"
date: 2011-05-09
comments: true
categories: ruby
author: "Kiyoshi Murata"
---

Just solved a few "obscure" problems and I'm posting them.

Dependencies
============

Optional (but you would *really* like to install them) dependencies are:

* OpenSSL (Debian-based package: libssl-dev)
* readline (Debian-based package: libreadline5-dev [ruby1.8] | libreadline6-dev [ruby1.9]. _For Ruby1.8, *you must install readline 5*, otherwise you'll get a damn slow prompt_)
* zlib (Debian-based package: zlib1g-dev)

Here are a few compeling motives on why you'd really like to get them:

* No SSL means no 'net/https' and no HTTPs for 'open-uri'
* No readline means you can't hit 'up arrow' on IRB and get the previous command (no command history)
* No zlib means you can't install a gem

Long story short, install 'em. And get the right versions.
