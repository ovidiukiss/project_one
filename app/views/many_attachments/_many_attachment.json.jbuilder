# a = 2
json.extract! many_attachment, :id
json.attachments many_attachment.image.attachments.each do |images|
  json.set! :image_link, rails_blob_url(images)
  json.set! :small_image, rails_representation_url(images.variant(combine_options:
                                         { auto_orient: true,
                                           gravity: "center",
                                           resize: "100x100^",
                                           crop: "100x100+0+0" })
                                                                .processed, only_path: false)
  json.set! :big_image, rails_representation_url(images.variant(combine_options:
                                                                      { auto_orient: true,
                                                                        gravity: "center",
                                                                        resize: "400x400^",
                                                                        crop: "400x400+0+0" })
                                                              .processed, only_path: false)
end