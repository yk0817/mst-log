class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  PER = 10
  PER.freeze
end
