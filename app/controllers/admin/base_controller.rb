module Admin
  class BaseController < ApplicationController
    before_action :require_admin

    layout "admin" # Uses a dedicated admin dashboard layout
  end
end
