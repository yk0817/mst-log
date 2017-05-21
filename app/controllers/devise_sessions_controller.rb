class DeviseSessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
    redirect_to(home_path)
  end
end
