class TeamUpdateJob < ApplicationJob
  queue_as :default

  def perform(file)
    @error = 0
    teams = CSV.parse(file.open, col_sep: ',', headers: true)
    teams.each do |action|
      x = action.to_h

      team_params = { name: x.values[0], abbreviation: x.values[1] }
      manager_params = { team_id: Team.last[:id], first_name: x.values[2], last_name: x.values[3], age: x.values[4],
                         description: x.values[5] }

      if Team.find_by(name: x.values[0])
        Team.find_by(name: x.values[0]).update(team_params)
      elsif Manager.find_by(first_name: x.values[2])
        Manager.find_by(first_name: x.values[2]).update(manager_params)
      else
        @error += 1 unless Team.new(team_params).save
        @error += 1 unless Manager.new(manager_params).save
      end
    end
    BulkReportMailer.bulk_report(@error, teams.count - @error).deliver_now
  end
end
