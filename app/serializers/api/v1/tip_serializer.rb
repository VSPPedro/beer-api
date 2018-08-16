class Api::V1::TipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description
end
