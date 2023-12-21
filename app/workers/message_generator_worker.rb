


class MessageGeneratorWorker
  include Sneakers::Worker
  include Modules::AmqpErrorReporter

  from_queue 'message_generator',
             exchange: 'red_piccolo',
             exchange_type: 'direct',
             workers: 1,
             threads: 4,
             durable: true

  # This method handles incoming messages from the queue.
  # It unpacks the message using MessagePack, logs the message,
  # and acknowledges the message once processed.
  #
  # In case of a StandardError exception, it logs the exception
  # details and requeues the message.
  #
  # @param msg [String] the message payload from the queue, encoded in MessagePack format
  # @return [:ack | :reject | :requeue]
  def work(msg)
    logger.level = Logger::WARN
    begin
      with_amqp_error_reporting do
        message = JSON.parse(msg, symbolize_names: true)
        logger.info "Received message: #{message}"
        3.times { publish({content: SecureRandom.hex(32)}.to_json, routing_key: 'message_generator') }
        DomainServices::Chat::SendMessageService.call(User.first, Chat.first, message[:content])
        ack!
      end
    rescue StandardError => e
      logger.error [e.class, e.message, e.backtrace[0..4]]
      requeue!
    end
  end
end
