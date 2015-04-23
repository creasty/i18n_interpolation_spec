module I18nInterpolationSpec
  module Helper

    def failed(&block)
      if respond_to? :failure_message
        # Rspec 3
        failure_message { |f| instance_exec(f, &block) }
      else
        # Rspec 2
        failure_message_for_should { |f| instance_exec(f, &block) }
      end
    end

  end
end
