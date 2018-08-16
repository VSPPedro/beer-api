class Api::V1::VolumeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :value, :unit
end
