---
layout: post
title: "On-demand social sharing buttons"
date: 2012-01-28 17:50
author: "Kiyoshi '13k' Murata"
comments: true
categories: javascript facebook twitter google-plus
---

Today is very common to see social sharing buttons right beside to some content.
Most common ones are Facebook's
[Like](http://developers.facebook.com/docs/reference/plugins/like/), Twitter's
[Tweet](https://dev.twitter.com/docs/tweet-button) and Google's
[+1](https://developers.google.com/+/plugins/+1button/). They are virtually
everywhere, even on their own documentation pages. Product owners and managers
love them. Common people use them a lot. So they are, in fact, unavoidable. They
are so omnipresent that some even think they are annoying enough to make
[browser extensions to block them](https://chrome.google.com/webstore/detail/phfgfpbcplmockgngcmgnalfnploegfi?utm_source=chrome-ntp-icon).
So, in the end, everyone is writing code because of them.

Of course, I was one of them too.

As a content consumer, I do not hate them. They make my life easier by putting
me one click away from telling the whole world what I like and why (ok, that's
sarcastic). But they actually do help.

As a developer, _I do hate them_. They suck. They are some little freaking wild
embedded pieces of code that you cannot expect to control. Not on edge cases,
specially those your PO or manager put you into (when they want you to make the
buttons dance with perfect lip-sync to Lady Gaga's latest hit).  I hate them
when they don't have every possible option to customize their style,
positioning or behavior.  And lastly I hate when you use them in a page with 10
items that I want the user to be able to share, and they perform
[**two hundred requests**](http://img692.imageshack.us/img692/3383/screenshot0128201206402.png).

Now, no one likes hundreds of requests. Not my mom, you, your ISP or your cheap
10 buck wireless router (even it not being totally aware of his own existence).

So a really smart thing to do is _do not perform hundreds of requests_. Right?

**Q:** You cutie, but how?  
**A:** Ok, here is a story that will explain all things: in the
early 2000's, IBM pioneered something called on-demand computing... no, I'm just
kidding. What you do is: _don't show them bugger buttons. It's simple._

**Q:** But kid wants to share my content with his friends!  
**A:** You display a handle that will trigger the actual rendering of the
buttons, **on-demand**.

Attaboy! There is my IT jargon shining on my blog post. _Inside a
<strike>pointless</strike> Questions & <strike>meaningless</strike> Answers
list_. Double score, yes.

Now, you want code, I know. Then take it!

{% gist 3210269 %}

So, after all that shitstorm of non optimized code entangled by all that
commenting, you and me will agree, there's one question that will be left
forever unanswered:

### Will this code compile?

Good night, and good luck.
