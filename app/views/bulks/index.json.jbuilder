
# frozen_string_literal: true

json.array! @bulk do |bulk|
  json.extract! bulk, :id, :filename, :content_type
end
