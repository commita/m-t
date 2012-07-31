--- 
title: Rubber and whenever integration
date: 25/02/2011
author: Kiyoshi Murata
layout: post
comments: true
categories: rubber whenever ruby
--- 

If you are using [rubber](http://github.com/wr0ngway/rubber) gem to deploy to
Amazon's EC2 infra-structure and also using
[whenever](http://github.com/javan/whenever) to manage cron jobs, you'll
probably find yourself thinking how to integrate both.

I myself too was wondering about this. The obvious first try was to add
_whenever_'s capistrano tasks to `config/deploy.rb` by following its
[recommendation](http://github.com/javan/whenever/blob/master/README.md) (see
the "Capistrano integration" section). Long story short, it didn't work. When I
deployed with `cap deploy`, _whenever_ would actually write to crontab, but
only to be replaced by _rubber_'s own version later, as we can see in this log:

{% gist 843670 %}

Last line shows when _rubber_ transforms and runs the common crontab config and
overwrites _whenever_'s cron jobs.

So, a second, and more successful, try was to avoid capistrano's regular
recipes and instead add a _whenever_ crontab config to _rubber_.

One could "quick-and-dirty"-ly add the expected _whenever_ output to
`config/rubber/common/crontab` file, but a better approach is to create a
config for the `db` role to install _whenever_ output to crontab:

{% gist 843668 %}

_One note on the above is to pay attention to keep the `@additive`
configuration so the crontab is appended with this section rather than
overwritten. If you check the `config/rubber/common/crontab` file, it hasn't
this entry and effectively overwrites the previous crontab._

And that was it. One `cap deploy` and the crontab was filled with _rubber_'s
jobs and _whenever_'s too.
