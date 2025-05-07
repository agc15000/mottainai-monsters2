class GenerateMonsterMessagesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserMonster.find_each do |user_monster|
      if user_monster.user.present? # ユーザーが存在するか確認
        conversation = Conversation.find_or_create_by(user: user_monster.user, user_monster: user_monster)
        generator = MonsterMessageGenerator.new(user_monster)
        message_content = generator.generate

        conversation.monster_messages.create(
          content: message_content,
          sender_type: 'monster'
        )
        puts "自動メッセージを送信しました: ユーザーID #{user_monster.user_id}, モンスター #{user_monster.monster_name}, 会話ID #{conversation.id}" # ログ
      end
    end
  end
end
