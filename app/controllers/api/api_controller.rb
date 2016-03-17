class Api::APIController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :restrict_access, only: [:create, :update, :destroy]
end