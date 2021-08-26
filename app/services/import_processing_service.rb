class ImportProcessingService
  attr_accessor :import

  def initialize(import)
    @import = import
  end

  def call!
    table = import.attachment.present? ? CSV.parse(File.read(import.attachment.file&.file), headers: true) : []

    import.update(state: :started, started_at: Time.now)

    table.size.times do |i|
      create_customer(table[i])
    rescue ActiveRecord::RecordInvalid
      import.invalid_customers += 1
    end

    import.update(state: :completed, completed_at: Time.now)
  end

  def create_customer(i)
    Customer.create!(
      first_name: i['first_name'],
      last_name: i['last_name'],
      email: i['email'],
      date_of_birth: i['date_of_birth'],
      import: import
    )
  end
end
