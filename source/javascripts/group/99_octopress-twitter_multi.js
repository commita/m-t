octopress.twitterMulti = (function() {
  function linkifyTweet(text, url) {
    // Linkify urls, usernames, hashtags
    text = text.replace(/(https?:\/\/)([\w\-:;?&=+.%#\/]+)/gi, '<a href="$1$2">$2</a>')
      .replace(/(^|\W)@(\w+)/g, '$1<a href="http://twitter.com/$2">@$2</a>')
      .replace(/(^|\W)#(\w+)/g, '$1<a href="http://search.twitter.com/search?q=%23$2">#$2</a>');

    // Use twitter's api to replace t.co shortened urls with expanded ones.
    for (var u in url) {
      if(url[u].expanded_url != null){
        var shortUrl = new RegExp(url[u].url, 'g');
        text = text.replace(shortUrl, url[u].expanded_url);
        var shortUrl = new RegExp(">"+(url[u].url.replace(/https?:\/\//, '')), 'g');
        text = text.replace(shortUrl, ">"+url[u].display_url);
      }
    }
    return text;
  }

  function render(tweets, twitter_user) {
    var timeline = $('#tweets-' + twitter_user),
        content = '';

    for (var t in tweets) {
      content += '<li>'+'<p>'+'<a href="http://twitter.com/'+twitter_user+'/status/'+tweets[t].id_str+'">'+octopress.prettyDate(tweets[t].created_at)+'</a>'+linkifyTweet(tweets[t].text.replace(/\n/g, '<br>'), tweets[t].entities.urls)+'</p>'+'</li>';
    }

    timeline.html(content);
  }

  return {
    getFeed: function(target) {
      target = $(target);
      if (target.length == 0) return;
      var user = target.attr('data-user');
      var count = parseInt(target.attr('data-count'), 10);
      var replies = target.attr('data-replies') == 'true';
      $.ajax({
          url: "http://api.twitter.com/1/statuses/user_timeline/" + user + ".json?trim_user=true&count=" + (count + 20) + "&include_entities=1&exclude_replies=" + (replies ? "0" : "1") + "&callback=?"
        , dataType: 'jsonp'
        , error: function (err) { target.find('li.loading').addClass('error').text("Twitter's busted"); }
        , success: function(data) { render(data.slice(0, count), user); }
      });
    }
  }
})();

$(document).ready(function() {
  $(".tweets").each(function(i, e) {
    octopress.twitterMulti.getFeed("#" + e.id);
  });
});
