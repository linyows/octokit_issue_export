OctokitIssueExport
==================

Export issues from projects on GitHub

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

```
# Provide authentication credentials
Octokit.configure do |c|
  c.login = 'defunkt'
  c.password = 'c0d3b4ssssss!'
end

# Fetch the current user
Octokit.export_org_issues('rails')
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

- [@linyows](https://github.com/linyows)


License
-------

MIT
