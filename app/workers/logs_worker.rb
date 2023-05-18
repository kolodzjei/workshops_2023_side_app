class LogsWorker
  include Sneakers::Worker

  from_queue 'basic_app_book_logs', exchange: 'basic_app', exchange_type: :direct, routing_key: 'basic_app.book_loans'

  def work(msg)
    Log.create(log_attributes(JSON.parse(msg)))
  end

  private

  def log_attributes(message)
    {
      user_id: message["user_id"],
      data: message.except("user_id")
    }
  end
end