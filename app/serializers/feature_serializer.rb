require 'active_model/serializer'

class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :type, :links

  def json_key
    "data"
  end

  def custom_attributes
    {
      external_id: object.usgs_id,
      magnitude: object.magnitude,
      place: object.place,
      time: object.time.iso8601,
      tsunami: object.tsunami == 1,
      mag_type: object.mag_type,
      title: object.title,
      coordinates: {
        longitude: object.longitude,
        latitude: object.latitude
      }
    }
  end

  attribute :custom_attributes, key: :attributes do
    {
      external_id: object.usgs_id,
      magnitude: object.magnitude,
      place: object.place,
      time: object.time.iso8601,
      tsunami: object.tsunami == 1,
      mag_type: object.mag_type,
      title: object.title,
      coordinates: {
        longitude: object.longitude,
        latitude: object.latitude
      }
    }
  end

  def links
    {
      external_url: object.url
    }
  end

end
