class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :usgs_id, :magnitude, :place, :time, :url, :tsunami, :mag_type, :title, :longitude, :latitude
end
