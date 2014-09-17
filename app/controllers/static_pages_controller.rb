class StaticPagesController < ApplicationController
	before_action :admin_user, only: [:forum_settings]

  def home
  end

  def help
  end

  def about
  end

  def forum_settings
  	add_breadcrumb "Forum Settings", :forum_settings_path
  end
end
