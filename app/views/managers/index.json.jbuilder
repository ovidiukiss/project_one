json.array! @managers do |manager|
  json.partial! 'manager', manager: manager
end