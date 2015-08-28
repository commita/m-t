--- 
title: Contributing to Rails
date: 12/04/2010
author: Kristopher Murata
layout: post
comments: true
categories: rails opensource contrib
--- 

{% img left https://www.dropbox.com/s/9dr5v9z0tkznw35/contributing-to-rails.jpg?dl=1 300 '' Contributing to Rails %}

I had a draft of this article on a paper since my first contribution to Rails Core was accepted 
approximately a week ago and I was postponing to write it because 1) I didn't have enough experience, 
2) the article would sound a lot like shameless self-promotion and 3) write in English is still a pain in the ass.

However, I got really impressed of what I read tonight on this _aggressive_ article 
[Want It? Give.](http://ryanbigg.com/2010/04/want-it-give/) by [Ryan Bigg](http://ryanbigg.com/) 
(I could really listen to [DHH](http://www.loudthinking.com/) talking on a conference on that tone.. am I 
[that](http://thisweekin.com/thisweekin-startups/twist-46-with-david-heinemeier-hansson-2/) crazy?), so I decided 
to write the article anyway (which doesn't mean that I overcame all of my 3 points above, they can still be true). 

Although I'm not a big fan of tirades, they can be very effective and make us motivated to do something, and on 
this case hopefully it's a healthy thing! If you aren't convinced to start contributing to Rails 
[right now](https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/bins/5837), go read this article too 
[Pledge 3 Percent for Rails 3](http://www.enlightsolutions.com/articles/pledge-3-percent-for-rails-3/) by 
[Dan Pickett](http://www.enlightsolutions.com/).

Now that Bigg and Pickett got you motived to contribute to [Rails](http://rubyonrails.org/) , it's time to learn on 
how to do it, there's plenty of instructions around on how to send a patch to Rails, I'm not going to reproduce it here, 
so I recommend you to read/watch the following first:

- [\#113 Contributing to Rails with GIT](http://railscasts.com/episodes/113-contributing-to-rails-with-git) from Railscasts
- [Contributing to Rails](https://rails.lighthouseapp.com/projects/8994/sending-patches) from Rails Lighthouse
 
Enough on motivational talk, those articles can fullfil "Why I should contribute to Rails", so I will go through some 
questions that I asked myself when trying to contribute to rails and I wanted to share.

### How I find something to fix or add on Rails?

I got used to think that all problems on Rails were solved by Rails Rockstars and there wasn't bugs left to fix neither 
features that I could add. If you think like this, I have to tell that you are wrong, as I was. I'm not a great developer 
and definitely not that smart, and still I was able to do my part.

If you didn't find a bug or something that you think 'should be nice have X on Rails' you probably aren't playing with 
Rails that much, but still you can find a lot of [patches](https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/bins/5805)
to test and [bugs](https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/bins/5837) to fix on 
[Rails Lighthouse](https://rails.lighthouseapp.com/projects/8994-ruby-on-rails).

### Where should I start?

You start from the obvious beginning when talking about Test Driven Development: writing failing tests. Rails has a rock 
solid test suite and you have to embrace it, love it, cultivate it, treat it like your own son! When you are dealing with 
a bugfix, write the missing test case or when adding a new feature modify the existing tests (if necessary) and add more 
tests designing your feature.

### Where I should insert method X? What's the best design for feature Y?

Read the manual and play around. You have a new toy, you don't know how to play with it, what you should do is read the 
damn manual and start playing with it. So, read the [Rails API](http://api.rubyonrails.org/) and start doing ugly things, 
it's your own copy of Rails and you want to know how things works, if you are not sure what all that modules and classes 
are all about start doing copy/paste (build your own Rails frankenstein!) and see what happens. It's even valid do PDD - 
Puts Driven Development (as would say [Rafael](http://flavors.me/rafaelss), I friend of mine).

### Feature or Bugfix?

I would strongly recommend you to start with bugfixes, they are all over the place and will not stop growing anytime soon. 
However, if you are thinking of adding a new feature on Rails, first discuss it on [Rails Core mailing list](http://groups.google.com/group/rubyonrails-core).

As you may know, Rails has some quite strong opinions about a lot of things, and most of the time when talking about new 
features what sounds good to you is far away of what the [Rails Core Team](http://rubyonrails.org/core) thinks, so be 
careful when trying to sell your shiny new feature that *you* think will be awesome-freaking-good on Rails. 

### How should I post my ticket?

Be straight to the point, no one will read a very long text neither guess what your one line bug description means. You 
should follow this simple script:

- Describe it shortly
- Post a step by step how to reproduce the bug
- Post OS, database, rails version or whatever you think should be relevant

In case of a patch you can add:

- Describe where was the problem and..
- Why you took that approach to fix the problem?

### What makes my contribution good enough?

- If I had just a few words to say, it would be: **a lot of tests**. That's it, you have to write tests for every single 
case, doing a one line patch on Rails could easily mean writing 30 lines of tests. The commiter who will evaluate your 
patch will look essentially your tests and if they cover all cases, so don't hesitate on writing a lot of them, tests 
are always welcome.
- Write good documentation in case of features.
- Be polite and collaborative, no one will look at your bug report if you are an asshole or test your patch if you 
are arrogant.

### Conclusion

Although the goal is clear enough: make a better software and contribute for a greater cause. I think that the most useful
thing that I could get from this enjoyable experience is **the whole process**, because I learned **a lot**. This motive 
should be enough for anyone seeking on improving his programming skills and can't handle doing nothing useful on Sundays. :)

And this article is only a **personal experience and opinion** from a greedy Rails contributor. I can be very wrong on 
some subjects, feel free to enlighten me and join the discussion.
 
_Happy Rails Hacking._

