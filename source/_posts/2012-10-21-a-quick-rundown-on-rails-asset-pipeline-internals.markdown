---
layout: post
title: "A quick rundown on Rails asset pipeline internals"
date: 2012-10-21 06:02
comments: true
author: "Kiyoshi '13k' Murata"
---

I was trying to understand how Rails' asset pipeline works internally, so I had
a quick code reading, annotating with bullet points each important step, then I
thought about sharing it, may be helpful to others.

Note that this is for Rails 3.2.8, all links point to 3.2.8 tagged code.
Sprockets integration with Rails 4.x is extracted to the
[sprockets-rails][sprockets-rails] gem.

* Rails sets the default asset paths, setting `config.assets.paths`
  ([here][assets_paths]). `config.assets.paths` is the array that's gonna be
  appended to the Sprockets environment load path.
* Rails sets the default accepted assets paths (rules in fact), setting
  `config.assets.precompile` ([here][assets_precompile]).
  `config.assets.precompile` is the array that stores all rules that will be
  used to judge whether a asset is to be compiled or not.
* [ User can configure in `config/application.rb` or
  `config/environments/<env>.rb` more rules to add to
  `config.assets.precompile` ]
* Rails instantiates and configures a Sprockets environment via railties using
  the configuration above ([here][sprockets_env])
* Rails will postpone configuring the Sprockets environment paths because other
  gems could add more paths to the `config.assets.paths`. Instead, it runs a
  `Sprockets::Bootstrap` after Rails is initialized
  ([here][sprockets_bootstrap])
* `Sprockets::Bootstrap` will then append `config.assets.paths` to the
  sprockets env paths ([here][sprockets_append_paths])
* Now assets are configured, assets will be compiled when `rake
  assets:precompile` is called, which will in turn instantiate a
  `Sprockets::StaticCompiler` (provided by action_pack, not sprockets itself)
  instance and run ([here][assets_task])
* The compiler iterates over every single path inside the load paths,
  recursively, and tests each entry against the rules defined in
  `config.assets.precompile`, if any returns positively, it then compiles the
  asset and writes to the target directory ([all that is here][sprockets_compiler])

[assets_paths]: https://github.com/rails/rails/blob/v3.2.8/railties/lib/rails/engine.rb#L574-578
[assets_precompile]: https://github.com/rails/rails/blob/v3.2.8/railties/lib/rails/application/configuration.rb#L48
[sprockets_env]: https://github.com/rails/rails/blob/v3.2.8/actionpack/lib/sprockets/railtie.rb#L23
[sprockets_bootstrap]: https://github.com/rails/rails/blob/v3.2.8/actionpack/lib/sprockets/railtie.rb#L58-60
[sprockets_append_paths]: https://github.com/rails/rails/blob/v3.2.8/actionpack/lib/sprockets/bootstrap.rb#L12
[assets_task]: https://github.com/rails/rails/blob/v3.2.8/actionpack/lib/sprockets/assets.rake#L50-56
[sprockets_compiler]: https://github.com/rails/rails/blob/v3.2.8/actionpack/lib/sprockets/static_compiler.rb

[sprockets-rails]: https://github.com/rails/sprockets-rails
