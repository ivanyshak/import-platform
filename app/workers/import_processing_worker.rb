class ImportProcessingWorker
  include Sidekiq::Worker

  def perform(id)
    import = Import.find(id)
    ImportProcessingService.new(import).call!
  end
end
