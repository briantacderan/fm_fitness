class PagesController < ApplicationController

  def home
    @plans = Plan.all
    @user = current_user
  end
    
  def about
  end
    
  def programs
    @personal = Plan.where(program_id: 1)
    @group = Plan.where(program_id: 2)
    @nutrition = Plan.where(program_id: 3)
  end
    
  def testimonials
  end

end