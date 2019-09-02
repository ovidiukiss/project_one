class CreateBulkJob < ApplicationJob
  queue_as :default

  def perform(id)
    @error = 0
    file_data = Bulk.find_by(id: id).file.download
    teams = CSV.parse(file_data, col_sep: ',', headers: true)
    teams.each do |action|
      x = action.to_h
      @error += 1 if Team.new({ x.keys[0] => x.values[0], x.keys[1] => x.values[1] }).save
      @error += 1 if Manager.new({ team_id: Team.last[:id], x.keys[2] => x.values[2], x.keys[3] => x.values[3], x.keys[4] => x.values[4], x.keys[5] => x.values[5] }).save

    end
    BulkReportMailer.bulk_report(@error, teams.count-@error).deliver_now
  end
end