--- 
title: Bash regexp trick
date: 05/07/2011
author: Kiyoshi Murata
layout: post
comments: true
categories: bash regex
--- 

Yesterday I was playing with my bash prompt and for a long-explanation reason,
I ended up needing to strip non-printing sequences from a string (the actual
reason is that I was up to learn and do some advanced bash scripting. I didn't
need all the complex stuff before).  From section PROMPTING of bash(1) man
page, non-printing escape sequences are:

    \[     begin  a sequence of non-printing characters, which could
           be used to embed a terminal  control  sequence  into  the
           prompt
    \]     end a sequence of non-printing characters

So it seems pretty easy to match those, isn't? If done with Ruby, it would be
simply:

{% codeblock lang:ruby %}
"[np1]text1-[np2]text2".gsub /\[.*?\]/, "" # => "text1-text2"
{% endcodeblock %}

then you'd think you could use the awesome pattern substitution in parameter
expansion, like this simple example:

{% codeblock lang:bash %}
text="hello world"
echo "${text//hello/adios}" # "adios world"
{% endcodeblock %}

but bash's regexp has no greediness modifiers (like the question mark in Ruby
or PCRE) to be used in the "inside part" of the pattern (the "anything" between
\\[ and \\]). The usual trick to workaround this is to use a negated pattern of
the right end of the enclosing pattern:

{% codeblock lang:bash %}
text="aaa<skipme>bbb<skipmetoo>ccc"
echo "${text//<*([^>])>/}" # "aaabbbccc"
{% endcodeblock %}

This works with patterns that use single characters to enclose the content, but
what I want is to replace patterns matching content enclosed by pairs of 2
chars, so I would need to use the negation operator `!(...)`. But boy... have I
tried to make it work? Hell, for hours. It's completely counter-intuitive.
This won't work:

{% codeblock lang:bash %}
text="aaa<<skipme>>bbb<<skipmetoo>>ccc"
echo "${text//<<!(>>)>>/}" # "aaaccc", since /!(>>)/ matches all the "skipme ... skipmetoo" part
{% endcodeblock %}

and this, plus all variations, won't work too:

{% codeblock lang:bash %}
text="aaa<<skipme>>bbb<<skipmetoo>>ccc"
echo "${text//<<*([^>][^>])>>/}" # "aaabbb<<skipmetoo>>ccc"
{% endcodeblock %}

so here's my deal: screw with it. A nice alternate solution seems obvious now:
replace all double-char enclosing sequences with a (very easily distinctive)
single char, then use the solution above.

{% codeblock lang:bash %}
# Char 0x06 is the non-printable "ACK".
# What are the odds this char will happen inside a string?
# You need to use as $var because the regexp won't accept "\x06" in the pattern
ch=`echo -e '\x06'`
text="aaa<<skipme>>bbb<<skipmetoo>>ccc"
tmp="${text//@(<<|>>)/$ch}"
echo "${tmp//${ch}*([^${ch}])${ch}}" # "aaabbbccc"
{% endcodeblock %}

... and it works. I wrapped it up and added some more stripping utils:

{% gist 1065448 %}

Now let me continue learning bizarre topics and finish my
shell prompt.
