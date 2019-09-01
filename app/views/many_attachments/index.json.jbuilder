
# frozen_string_literal: true

json.array! @many do |many|
  json.extract! many, :id
end
