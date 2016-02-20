# MovieBase

[![Build Status](https://travis-ci.org/jmkuehn/MovieBase.svg?branch=master)](https://travis-ci.org/jmkuehn/MovieBase)

MovieBase is a HackIllinois 2015 project! More info to come when we have some downtime!

## How it works

TODO...

## Hacking on MovieBase

### Get started

New to Ruby? No worries! You can follow these instructions to install a local server.

#### Installing a Local Server

First things first, you'll need to install Ruby 2.3.0. We recommend using [rbenv](https://github.com/sstephenson/rbenv).

```bash
rbenv install 2.3.0
rbenv global 2.3.0
```

Note: If you don't have rbenv, install it like this: `brew install rbenv`

Next, you'll need to make sure that you have PostgreSQL installed. This can be
done easily on OSX using [Homebrew](http://brew.sh)

```bash
brew install postgresql
```

You will want to set postgresql to autostart at login via launchctl, if not already. See `brew info postgresql`.

Now, let's install the gems from the `Gemfile` ("Gems" are synonymous with libraries in other languages).

```bash
gem install bundler && rbenv rehash
```

### Setup MovieBase

Once bundler is installed go ahead and run the `setup` script

```bash
script/setup
```

### Running the application

Just run `rails server` and that's it! You should have a working instance of MovieBase located [here](http://localhost:3000)

## Deployment

We strongly encourage you to use [https://MovieBase.herokuapp.com](https://MovieBase.herokuapp.com), but if you would like your own version, MovieBase can be easily deployed to Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Contributing

We'd love to have you participate. Please check out our [contributing guidelines](CONTRIBUTING.md).

## Contributors

MovieBase is developed by these [contributors](https://github.com/jmkuehn/MovieBase/graphs/contributors).

## Thanks

Thanks to [Classroom for GitHub](https://github.com/education/classroom) for the lovely README and scripts!
