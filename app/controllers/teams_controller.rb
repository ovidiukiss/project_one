# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy download_logo]

  def index
    @teams = Team.all

    TeamMailer.send_report.deliver_later
  end

  def show
    head :not_found unless @team.present?
  end

  def download_logo
    send_data(@team.logo.download, filename: 'logo.jpg')
    #redirect_to rails_blob_url(@team.logo)
  end

  def create
    if params[:name].present?
      @team = Team.new(team_params)
      @team.logo.attach(params[:logo]) if params[:logo].present?
      @team_created = 'team'
    elsif params[:name].blank? && params[:file].present?
      @team_created = 'bulk'
      read_csv(params[:file])
    else
      handle_error(@team.errors)
    end

    if @team_created == 'team'
      render :show, status: :created
    elsif @team_created == 'bulk'
      bulk_creating
    else
      handle_error(@team.errors)
    end

  end

  def update
    if @team.update(team_params)
      render :show
    else
      handle_error(@team.errors)
    end
  end

  def destroy
    if @team.destroy
      render :head
    else
      handle_error(@team.errors)
    end
  end

  private

  def read_csv(file)
    if params[:file].content_type.include?('csv')
      if CSV.parse(file.open, col_sep: ',', headers: true).count > 1000
        TeamUpdateJob.perform_later(file)
      else
        TeamUpdateJob.perform_now(file)
        end
    else
      logger.error "File type not csv"
    end
  end

  def permitted_params
    params.permit(:id)
  end

  def team_params
    params.require(:name)
    params.permit(:name, :abbreviation, logo: [], file: [])
  end

  def set_team
    @team = Team.find(permitted_params[:id])
  end
end
