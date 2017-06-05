require "pathname"

module Capistrano
  module SecretsGenerate
    module Paths
      def secret_token_path
        return Pathname.new(fetch(:secret_file))
      end

      def secret_token_linked_path
        return shared_path.join(secret_token_path)
      end

      def secret_token_linked_dir
        return secret_token_linked_path.join('..')
      end

      def secret_token_current_path
        return current_path.join(secret_token_path)
      end
    end
  end
end
