require 'openai'

    class MessageGenerator
      def initialize(user_monster, user)
        @user_monster = user_monster
        @user = user
        @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY']) # 環境変数にAPIキーを設定
      end

      def generate_monster_message
        prompt = generate_prompt
        response = @client.completions(
          parameters: {
            model: "text-davinci-003",
            prompt: prompt,
            max_tokens: 150
          }
        )
        response['choices'][0]['text'].strip
      end

      private

      def generate_prompt# ここでuser_monsterとuserの情報を使ってプロンプトを作成
        "#{user_monster.monster.name}（#{user_monster.monster.description}）が、#{user.name}に対して食材を無駄にしたことへの怨念の言葉を作成して。"
      end
    end