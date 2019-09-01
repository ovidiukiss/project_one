class BulkReportMailer < ApplicationMailer
  default from: 'delivery_reporter@example.com'

  def bulk_report(failed, success)
    mail(
        to:      'ssome_emailAddress@gmail.com',
        bcc:     'asddsd@asdad.com',
        message: "empty",
        subject: 'Bulk upload report',
        body: "The number of failed imports is: #{failed}\nThe number of success imports is: #{success}"
        )
  end
end
