class MonsterMessagesController < ApplicationController
  before_action :set_user
  before_action :set_conversation, only: [:index, :create]

  def index
    @monster_messages = @conversation.monster_messages.order(created_at: :asc)
    @new_monster_message = MonsterMessage.new(conversation: @conversation)
  end

  def create
    @monster_message = @conversation.monster_messages.new(monster_message_params)
    @monster_message.sender_type = 'user'

    if @monster_message.save
      redirect_to user_monster_messages_path(@user, conversation_id: @conversation.id), notice: 'メッセージを送信しました。'
    else
      render :index, alert: 'メッセージの送信に失敗しました。'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_conversation
    @conversation = @user.conversations.find(params[:conversation_id])
  rescue ActiveRecord::RecordNotFound
    # ここには新しい Conversation を作成する処理は含めない
    flash[:alert] = '会話が見つかりませんでした。'
    redirect_to user_monsters_path
  end

  def monster_message_params
    params.require(:monster_message).permit(:content)
  end
end