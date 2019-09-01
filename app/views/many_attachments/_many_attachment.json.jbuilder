# a = 2
json.extract! many_attachment, :id
json.attachments many_attachment.image.attachments.each do |images|
  json.set! :image_link, rails_blob_url(images)
end