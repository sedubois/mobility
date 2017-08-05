module Mobility
  module Backend
=begin

Adds {#for} method to backend to return ORM-specific backend.

@example KeyValue backend for AR model
  class Post < ActiveRecord::Base
    # ...
  end
  Mobility::Backends::KeyValue.for(Post)
  #=> Mobility::Backends::ActiveRecord::KeyValue

=end
    module OrmDelegator
      # @param [Class] model_class Class of model
      # @return [Class] Class of backend to use for model
      def for(model_class)
        namespace = name.split('::'.freeze)
        if Loaded::ActiveRecord && model_class < ::ActiveRecord::Base
          require_backend("active_record", namespace.last.underscore)
          const_get(namespace.insert(-2, "ActiveRecord".freeze).join("::".freeze))
        elsif Loaded::Sequel && model_class < ::Sequel::Model
          require_backend("sequel", namespace.last.underscore)
          const_get(namespace.insert(-2, "Sequel".freeze).join("::".freeze))
        else
          raise ArgumentError, "#{namespace.last} backend can only be used by ActiveRecord or Sequel models".freeze
        end
      end

      private

      def require_backend(orm, backend)
        begin
          require "mobility/backends/#{orm}/#{backend}"
        rescue LoadError
        end
      end
    end
  end
end
