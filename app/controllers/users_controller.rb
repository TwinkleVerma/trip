class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit]
  protect_from_forgery prepend: true
  include UsersHelper

  def index
    @user = []
    User.all.each do |user|
      user.roles.each do |role|
        if role.name == 'piolet'
          @user << user
        end
      end
    end
    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def edit
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end
end
