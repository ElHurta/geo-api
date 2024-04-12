class Api::V1::FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show update destroy ]

  # GET /features
  def index
    filters = params[:filters] || {}
    page = params[:page].to_i
    per_page = params[:per_page].to_i

    per_page = 1000 if per_page > 1000 || per_page <= 0

    features = Feature.all
    if filters[:mag_type].present?
      mag_types = filters[:mag_type].split(",")
      features = features.where(mag_type: mag_types)
    end

    @features = features.page(page).per(per_page)
    
    render json: @features, meta: {
      pagination: {
        current_page: @features.current_page,
        total: @features.total_count,
        per_page: @features.limit_value
      }
    }, adapter: :json
  end

  # GET /features/1
  def show
    render json: @feature
  end

  # POST /features
  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      render json: @feature, status: :created, location: @feature
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /features/1
  def update
    if @feature.update(feature_params)
      render json: @feature
    else
      render json: @feature.errors, status: :unprocessable_entity
    end
  end

  # DELETE /features/1
  def destroy
    @feature.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      params.require(:feature).permit(:usgs_id, :magnitude, :place, :time, :url, :tsunami, :mag_type, :title, :longitude, :latitude)
    end
end
