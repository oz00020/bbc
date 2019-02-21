
class RanksController < ApplicationController
before_action :find_page
before_action :find_rank, only: [:destroy]

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(rank_params)
    @rank.page_id = @page.id

    if user_signed_in?
      @rank.user_id = current_user.id
    end

    if @rank.save
      redirect_to rankingpage_path
    else
      redirect_to new_user_session_path
    end
  end
    def destroy
      @rank.destroy
      redirect_to rankingpage_path
    end

  private

  def rank_params
    params.require(:rank).permit(:rating)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def find_rank
    @rank = Rank.find(params[:id])
  end
end