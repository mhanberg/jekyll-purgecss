# Jekyll Purgecss

[![Build Status](https://travis-ci.com/mhanberg/jekyll-purgecss.svg?branch=master)](https://travis-ci.com/mhanberg/jekyll-purgecss)
[![Gem Version](https://badge.fury.io/rb/jekyll-purgecss.svg)](https://badge.fury.io/rb/jekyll-purgecss)

A Jekyll plugin for Purgecss.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-purgecss'
```

And then add this line to your application's `_config.yml`:

```yml
# _config.yml

plugins:
  - jekyll-purgecss

css_dir: "<css_dir>" # defaults to "css"
```

jekyll-purgecss only runs in production, so make sure that `JEKYLL_ENV=production` on the server where you build your site.

## Usage

Make sure you have [purgecss](https://www.purgecss.com/#cli) installed and has its binary located at `./node_modules/.bin/purgecss`.

Add your Purgecss configuration to a `purgecss.config.js` file in the root of your repository.

```javascript
// purgecss.config.js

module.exports = {
  // These are the files that Purgecss will search through
  content: ["./_site/**/*.html"],

  // These are the stylesheets that will be subjected to the purge
  css: ["./_site/css/site.css"] 
};
```

#### Tailwind CSS

If you are using [Tailwind CSS](https://tailwindcss.com), you'll need to add a custom `extractor`. More can be read on the Tailwind [documentation](https://tailwindcss.com/docs/controlling-file-size#removing-unused-css-with-purgecss).

```javascript
module.exports = {
  content: ["./_site/**/*.html"],
  css: ["./_site/css/site.css"],

  // Tailwind CSS config
  extractors: [{
    extractor: class {
      static extract(content) {
        return content.match(/[A-Za-z0-9-_:\/]+/g) || [];
      }
    },
    extensions: ["html"]
  }]
};

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mhanberg/jekyll-purgecss. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll Purgecss project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mhanberg/jekyll-purgecss/blob/master/CODE_OF_CONDUCT.md).
