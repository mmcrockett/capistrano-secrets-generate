# Capistrano::SecretsGenerate

Capistrano tasks for handling generating a `secret.token` when deploying Rails 4+ apps.

### Install

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.2.1'
      gem 'capistrano-secrets-generate', '~> 1.0.0'
    end

And then:

    $ bundle install

### Setup and usage

- make secret.yml load file `config/secret.token`:

        production: &production
          <% if ((false == Rails.env.test?) && (false == Rails.env.development?)) %>
            secret_key_base: <%= File.read(File.join(Rails.application.config.root, "config", "secret.token")) %>
          <% end %>

- add to `Capfile`:

        require 'capistrano/secrets_generate'

You can now proceed with other deployment tasks.

### How it works

On deployment:

- we look for `secret.token` file on the server shared dir<br/>
- if it exists, we add to linked files<br/>
- if not we look for file in current deployment, if it exists, we copy to shared and add to linked<br/>
- if nothing exists, then we use `rake secret` to create a new secret.<br/>
