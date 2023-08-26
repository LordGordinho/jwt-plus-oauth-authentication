class Api::TestsController < Api::ApplicationController
  def index
    render json: { ok: true }, status: :ok
  end
end