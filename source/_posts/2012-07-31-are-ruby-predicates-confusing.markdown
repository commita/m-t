---
layout: post
title: "Are Ruby predicates confusing?"
date: 2012-07-31 02:12
comments: true
external-url: 
categories: ruby drama
---

This repository was sitting on my GitHub account for a while and I didn't
really announced anything related to it, partially because I had to polish it
and because at that time I was already late to the party, but as the saying
goes: "better late than never".

Such a long disclaimer to introduce a repository, right? It's nothing really.
We know the Ruby (mostly Rails) community has periodical dramas, this was about
yet another one.

This one happened quite some time ago (it's from March 2012), and it involved
bikesheding (doesn't all of them somehow involve bikesheding?) about what a
Ruby predicate (a method ending in "?") should return. Not a freaking big deal,
is it? I am of the opinion that clear code is priority and for the sake of
clarity, returning boolean values on predicates is always good practice. A
rails core member doesn't think so and states that because truthy values are
truthy, it's ok to return them on predicates, even if this value is completetly
counter-intuitive like the number zero. Yeah, you can try it:

{% codeblock lang:ruby %} puts "yes" if 0 # => "yes" {% endcodeblock %}

So I wrote [Are Ruby Predicates Confusing?][url] in an attempt to make fun of
it.

`"I hope you enjoy it!" unless 0.nonzero?`

[url]: http://13k.github.com/ruby-predicates
