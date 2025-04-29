module UserMonstersHelper
  def chat_path_for(user, user_monster)
    conversation = Conversation.find_by(user: user, user_monster: user_monster)
    if conversation
      user_monster_messages_path(user, conversation_id: conversation.id)
    else
      # 新しい Conversation を作成し、その ID をパスに含める
      new_conversation = Conversation.create(user: user, user_monster: user_monster)
      user_monster_messages_path(user, conversation_id: new_conversation.id)
    end
  end
end