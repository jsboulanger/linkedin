module LinkedIn
  module Api
    module Communications

      # Send a message from the authenticated user to the recipients
      #
      # @param recipient_uids [Enumerable, String] The list of uids of all the recipients or one uid if there is only one recipient.
      # @param subject [String] The subject of the message.
      # @param body [String] The body of the message. Cannot contain HTML.
      def send_message(recipient_uids, subject, body)
        path = "/people/~/mailbox"
        recipients_uids = [recipient_uids] if recipients_uids.is_a?(String)

        rcpts = recipient_uids.map do |uid|
          {
            :person => {
              :_path => "/people/#{uid}"
            }
          }
        end

        params = {
          :subject    => subject,
          :body       => body,
          :recipients => { :values => rcpts }
        }

        result = post(path, ::MultiJson.encode(params), "Content-Type" => "application/json")
        result.code
      end
    end
  end
end
