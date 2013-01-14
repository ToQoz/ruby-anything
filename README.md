# RubyAnything
Provide [anything](http://www.emacswiki.org/Anything) interface for ruby. Adds `_anything_` method to Kernel.

![thumbnail](http://pic.toqoz.net/a74849e3c9c2e55afe925bba2dcc23dfd94184ca.png)

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'ruby-anything'
end
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install ruby-anything
```

## Usage

### Example1

Start pry
```sh
$ pry
[1] pry(main)> require 'ruby-anything'
=> true
[2] pry(main)> _anything_ Pry.methods
```

### Demo
http://www.youtube.com/watch?v=bCyTMCOBkVw&hd=1

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
