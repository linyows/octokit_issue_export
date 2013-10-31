Octokit IssueExport
===================

[![Gem Version][gem_badge]][gem]
[![Build Status][travis_badge]][travis]
[![Dependency Status][gemnasium_badge]][gemnasium]
[![Code Climate][codeclimate_badge]][codeclimate]
[![Coverage Status][coveralls_badge]][coveralls]

Octokit IssueExport is [Octokit][octokit] extension. Export issues from projects on GitHub.

Installation
------------

Add this line to your application's Gemfile:

    gem 'octokit_issue_export'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octokit_issue_export

Usage
-----

```ruby
[1] 2.0.0(main)> require 'octokit_issue_export'
=> true
[2] 2.0.0(main)> Octokit.export_org_issues('rails')
[rails/rails]
- #12673, state:   open, comments:   0, title: "Fix Timed thread-safety. Fixes #12069"
- #12672, state:   open, comments:   0, title: "unescapeHTML crashes with certain *.html_safe inputs"
- #12671, state:   open, comments:   4, title: "Rails 4.0.1.rc1:  undefined method `set_name_cache' for #<Module:...> (NoMethodError)"
- #12670, state:   open, comments:   1, title: "Optimize none? and one? relation query methods to use LIMIT 1 and COUNT."
- #12667, state:   open, comments:   1, title: "Fix Guide HTML validation"
...
# => ./rails/rails/12673.json
# => ./rails/rails/12672.json
# ...
```

when includes private repository

```ruby
Octokit.configure do |c|
  c.login = 'defunkt'
  c.password = 'c0d3b4ssssss!'
end

Octokit.export_org_issues('github')
```

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Author
------

- [@linyows][linyows]


License
-------

MIT

[gem]: https://rubygems.org/gems/octokit_issue_export
[gem_badge]: https://badge.fury.io/rb/octokit_issue_export.png
[travis]: http://travis-ci.org/linyows/octokit_issue_export
[travis_badge]: https://secure.travis-ci.org/linyows/octokit_issue_export.png?branch=master
[gemnasium]: https://gemnasium.com/linyows/octokit_issue_export
[gemnasium_badge]: https://gemnasium.com/linyows/octokit_issue_export.png?travis
[codeclimate]: https://codeclimate.com/github/linyows/octokit_issue_export
[codeclimate_badge]: https://codeclimate.com/github/linyows/octokit_issue_export.png
[coveralls]: https://coveralls.io/r/linyows/octokit_issue_export
[coveralls_badge]: https://coveralls.io/repos/linyows/octokit_issue_export/badge.png?branch=master
[octokit]: https://github.com/octokit/octokit.rb
[linyows]: https://github.com/linyows
