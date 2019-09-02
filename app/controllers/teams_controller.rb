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
    @team = Team.new(team_params)
    @team.logo.attach(params[:logo])

    if @team.save
      render :show, status: :created
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

  def permitted_params
    params.permit(:id)
  end

  def team_params
    params.require(:name)
    params.permit(:name, :abbreviation, logo: [])
  end

  def set_team
    @team = Team.find(permitted_params[:id])
  end
end
