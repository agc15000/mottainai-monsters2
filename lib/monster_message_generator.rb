require 'openai'

  class MonsterMessageGenerator
    def initialize(user_monster)
      @user_monster = user_monster
      @user = user_monster.user
      @monster = user_monster.monster
    end

    def generate
      prompt = generate_prompt
      ai_response = call_ai_api(prompt)
  
      ai_response.presence || default_message
    end

  private

    def generate_prompt# ここでuser_monsterとuserの情報を使ってプロンプトを作成
      "#{ @user.name }さんとのチャットで、#{ @monster.name }（#{ @user_monster.monster_name }）が#{ @user_monster.message }と言っています。これに対して、#{ @monster.name }の粗末に扱われたことに対する恨みの思いをこめてメッセージを考えて。"
    end

    def call_ai_api(prompt)
      client = OpenAI::Client.new(api_key: Rails.application.credentials.openai_api_key)
      begin
        response = client.chat(
          parameters: {
            model: "gpt-3.5-turbo", # または "gpt-4" などの利用したいモデル
            messages: [{ role: "user", content: prompt }],
            temperature: 0.7, # 応答のランダム性 (0.0 - 1.0)
          }
        )
        response.dig("choices", 0, "message", "content")&.strip
      rescue OpenAI::Error => e
        puts "OpenAI API エラー: #{e.message}"
        nil # エラー発生時は nil を返すか、デフォルトメッセージを返すなどのエラーハンドリング
      end
    end
  
    def default_message
      "#{ @monster.name }は恨みつらみを吐いている…"
    end
  end