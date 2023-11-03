class AbstractService
    BASE_URL = 'https://emailvalidation.abstractapi.com/v1/'.freeze
    API_KEY = ENV['ABSTRACT_API_KEY']
  
    class << self
        def validate_email(email)
            response = Faraday.get(BASE_URL) do |req|
                req.params['api_key'] = API_KEY
                req.params['email'] = email
            end

            return_response_or_raise_error(response, 'Product family')
        end
  
      private
      def return_response_or_raise_error(response, *args)
        case response.status
        when 200..299
          JSON.parse(response.body.empty? ? '{}' : response.body)
        else
          raise ExternalServiceError.new('message' => JSON.parse(response.body.empty? ? '{}' : response.body))
        end
      end
    end
  end  