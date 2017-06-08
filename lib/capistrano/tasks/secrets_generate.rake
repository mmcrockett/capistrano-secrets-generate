include Capistrano::SecretsGenerate::Paths
include Capistrano::SecretsGenerate::Helpers

namespace :load do task :defaults do
    set(:secret_file, File.join("config", "secret.token"))
  end
end

namespace :secrets_generate do
  desc "Generate `secret.token` if none exists, otherwise copy and append to soft-link list."
  task :check_secret do
    on release_roles :all do
      secret_token_linked_exists  = test("[ -f #{secret_token_linked_path} ]")
      secret_token_current_exists = test("[ -f #{secret_token_current_path} ]")

      if ((false == secret_token_current_exists) && (false == secret_token_linked_exists))
        before("deploy:assets:precompile", "secrets_generate:generate_secret")
      else
        if (false == secret_token_linked_exists)
          if (false == test("[ -d #{secret_token_linked_dir} ]"))
            execute(:mkdir, secret_token_linked_dir)
          end

          execute(:cp, secret_token_current_path, secret_token_linked_path)
        end

        append(:linked_files, secret_token_path)
      end
    end
  end

  desc "Use rake to generate new secret."
  task :generate_secret do
    on release_roles :all do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # Test that it works so we don't create bad file and it shows error.
          execute(:rake, 'secret')

          # Now run for real
          execute(:rake, 'secret', '>', secret_token_path)
        end
      end
    end
  end
end

before("deploy:check:linked_files", "secrets_generate:check_secret")
