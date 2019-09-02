
# frozen_string_literal: true

json.array! @many do |many|
  json.partial! 'many_attachment', many_attachment: many
end
