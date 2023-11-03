class  ExternalServiceError < StandardError
    attr_accessor :config,
                  :code,
                  :message,
                  :http_code
  
    def initialize(config)
      @config = config
      @code = config[:code]
      @message = config[:message]
      @http_code = config[:http_code]
    end
  
    class << self
      def const_missing(name, *arg)
        I18n.reload!
        err_hash = t(name)
        if err_hash.is_a? Hash
          err_hash[:name] = name
          return new(err_hash)
        else
          super
        end
      end
  
      def t(error_name)
        I18n.t("#{self.to_s.underscore + '.' + error_name.to_s.underscore}")
      end
    end
end