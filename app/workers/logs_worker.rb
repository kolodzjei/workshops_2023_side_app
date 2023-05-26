class LogsWorker
  include Sneakers::Worker

  from_queue 'basic_app_book_logs', exchange: 'basic_app', exchange_type: :direct, routing_key: ['basic_app.book_loans', 'basic_app.cancel_loans']

  def work_with_params(msg, delivery_info, metadata)
    Log.create(log_attributes(setup_message(msg, delivery_info)))
  end

  private

  def setup_message(msg, delivery_info)
    msg = JSON.parse(msg)
    msg.merge({ routing_key: delivery_info.routing_key })
  end

  def log_attributes(message)
    {
      user_id: message["user_id"],
      data: message.except("user_id")
    }
  end
end