class ImportsController < ApplicationController
  before_action :set_import, only: [:show, :edit, :update, :destroy, :remove_customers]

  def index
    @imports = Import.search(params).page params[:page]
  end

  def show
    # it was implemented to have possibility implement searching by customer table
    @customers = @import.customers.search(params)
  end

  def new
    @import = Import.new
  end

  def update
    @import.update(import_params)
    redirect_to root_path
  end

  def create
    import = Import.create!(import_params)
    redirect_to import_path(import)
  end

  def destroy
    @import.destroy!
    redirect_to root_path
  end

  def start_process
    ImportProcessingWorker.perform_async(params[:id])
  end

  # such actions should be moved to separate service
  def remove_customers
    @import.customers.destroy_all
    @import.update(state: :created, started_at: nil, completed_at: nil, invalid_customers: 0)
    redirect_to root_path
  end

  private

  def import_params
    params.require(:import).permit(:title, :attachment, :state)
  end

  def set_import
    @import = Import.find(params[:id])
  end
end