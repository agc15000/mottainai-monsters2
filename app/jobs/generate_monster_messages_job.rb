class GenerateMonsterMessagesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    UserMonster.all.each do |user_monster|
      user = user_monster.user
      conversation = Conversation.find_or_create_by(user: user, user_monster: user_monster)
      monster_message_generator = MonsterMessageGenerator.new(user_monster, user)
      monster_message_content = monster_message_generator.generate_message
      conversation.monster_messages.create(content: message_content, sender_type: 'monster')
    end
  end
end
