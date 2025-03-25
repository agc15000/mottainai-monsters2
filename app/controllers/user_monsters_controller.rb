class UserMonstersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_monsters = current_user.user_monsters.includes(:monster)
  end

  def new
    @user_monster = UserMonster.new
    @monsters = Monster.all
  end

  def create
    @user_monster = current_user.user_monsters.build(user_monster_params)
    if @user_monster.save
      redirect_to user_monsters_path, notice: 'モンスターを登録しました。'
    else
      @monsters = Monster.all
      render :new
    end
  end

  private

  def user_monster_params
    params.require(:user_monster).permit(:monster_id, :monster_name, :message)
  end
end