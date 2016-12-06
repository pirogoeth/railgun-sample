railgun-sample
==============

This is a super simple example Rails app demonstrating how to use Railgun / mailgun-ruby with a Rails app.


Installation
============

I recommend using (asdf-vm)[https://github.com/asdf-vm/asdf] to build a Ruby install.
Once you've set up your Ruby install:

```
# Make sure you've got Bundler installed
gem install bundler

# Install the Rails app bundle
bundle install

# Configure your Mailgun API key and domain
vim config/environments/development.rb
...

# Change the `default from:` address in the mailer
vim app/mailers/default_mailer.rb

# Run the Rails server
bundle exec bin/rails server
```

After running the server, you can navigate to http://localhost:3000/users/new
and sign up. You should receive an email shortly after finishing your sign up.
