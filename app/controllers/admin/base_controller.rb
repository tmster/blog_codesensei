module Admin
  class BaseController < ApplicationController
    layout "admin"

    http_basic_authenticate_with name: "dhh", password: "secret"

  end
end
