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

```javascript
// I dedicate this
//   To my family and friends;
//   To gods, old and new;
//   To be or not
//   To be.
//
// None of this would be possible without jQuery.
// Thank you so much.
//
// Tears.
//
$(document).ready(function() {
  // When kid mouseover's your handle
  $(".share-buttons-handle").hover(function() {
    // Everyone needs an identity in this world
    var handle_id = this.id;
    // Since you want to show buttons for this, and only this,
    // one unique content, you should have a way to identify each
    // piece, like an id for a blog post, which you will fetch
    // right
    // now!
    var content_id = $(this).data('contentId');
    // Note that you must put a data-content-id attribute to the
    // placeholder elements for this to work. Like this:
    // <a href="#" data-content-id="1" class="share-buttons-handle listen-to-your-heart">Get hover here now!</a>

    // With the content id, you can fetch the actual HTML for the
    // buttons on demand, via AJAX, from your own server and
    // put inside the placeholder that was there hiding,
    // plotting, scheming, waiting, lurking
    $("#hiding-plotting-scheming-waiting-lurking-placeholder-for-" + content_id).load("/path/to/your/thing/that/will/return/a/html/snippet/with/buttons/iframes/xfbml/whatever.your-I-cant-route-without-extensions-framework-file-extension", function() {
      // Here we have the HTML snippet loaded and injected into the placeholder
      // Now we can tell the freaking share APIs to parse and render buttons.
      // But as I am a very nice developer, I'll only show the box when the APIs
      // are actually done rendering, so I'll use custom events to signal this
      // to the handle that was hover()'ed.

      // For Facebook, you can use:
      FB.XFBML.parse(this, function() {
        // parse() will call this function when ready
        $("#" + handle_id).trigger("api-ready", "facebook");
      });

      // For Twitter, you can't actually tell the Javascript API to render when
      // you want to. So you need your AJAX call to return an Tweet button iframe.
      // I know, that is what it is. Luckily, jQuery's load() works for checking
      // when iframes are ready:
      // (you can use a class for this iframe for the sake of identity, but
      // the below will work too)
      $(this).find("iframe[src*='tweet_button']").load(function() {
        $("#" + handle_id).trigger("api-ready", "twitter");
      });

      // Lastly, you make Google render your freaking +1 button, for free:
      gapi.plusone.go(this);
      // Since it was free, you cannot hope to have a callback function to tell
      // you little spoiled child when it is ready, CAN YOU? Yes, I thought so.
      // But, I'm a spoiled child, I'll tell it's ready when I tell it's ready.
      // Google +1 API is like: whatever floats your boat, bro.
      $("#" + handle_id).trigger("api-ready", "plusone");
    });
  }, function() {
    // When kid mouseleave's your handle, hide them buggers!
    var content_id = $(this).data('contentId');
    $("#hiding-plotting-scheming-waiting-lurking-placeholder-for-" + content_id).hide();
  });

  // Now we want or prayers to be heard
  // The class used below should be on every hover()'ed handle
  // so they can actually Listen To Your Heart.
  $(".listen-to-your-heart").on("api-ready", function(ev, api) {
    var content_id = $(this).data('contentId');
    // Now we want to show only if all APIs are finished
    // so we do exactly none of it and show it anyway
    // because I'm lazy to write this part and you should do it your way

    // if (allAPIsAreFinishedFor(content_id))
    $("#hiding-plotting-scheming-waiting-lurking-placeholder-for-" + content_id).show();
  });
});
```

So, after all that shitstorm of non optimized code entangled by all that
commenting, you and me will agree, there's one question that will be left
forever unanswered:

### Will this code compile?

Good night, and good luck.
