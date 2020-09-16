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
  defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
};
```

## Deployment

Please note that this plugin isn't supported by [GitHub Pages](https://pages.github.com/versions/), which means by default you are not able to use it, when you are hosting your site at GitHub Pages. 

However if switching to another hosting platform (e.g.[Netlify](https://www.netlify.com/)) is nothing you want to do, there's the option to perform the build process via [GitHub Actions](https://github.com/features/actions).

To do that, you need to create a yml-workflow-file inside `.github/workflows` of your repository that represents your build process. This could look like the following:

```yaml
name: Build and deploy Jekyll to GitHub Pages

on:
  push:
    branches:
      - master

jobs:
  github-pages:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v2
      # Install Ruby to be able to build the site using Jekyll
      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 2.7
      # Install Node as this is needed for PurgeCSS
      - name: Setup Node
        uses: actions/setup-node@v1
        with:
          node-version: '14'
      # Install PurgeCSS (needs to be in your package.json)
      - run: npm install
      # Build site
      - name: Install dependencies & Build Site
        uses: limjh16/jekyll-action-ts@v2
        with:
          enable_cache: true
      # Push the compiled _site-folder as branch into your GitHub repository
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_site
```
See:
- https://github.com/limjh16/jekyll-action-ts/ for more details about the GitHub Action compiling your site

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mhanberg/jekyll-purgecss. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll Purgecss project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mhanberg/jekyll-purgecss/blob/master/CODE_OF_CONDUCT.md).
