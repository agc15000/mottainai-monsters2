require 'open-uri'

class ImagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @image = current_user.images.build
  end

  def create
    @image = current_user.images.build(image_params)

    if @image.save
      generate_and_save_dalle_image(@image)
      redirect_to @image, notice: '画像を生成しました。'
    else
      render :new
    end
  end

  def show
    @image = current_user.images.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:image_title)
  end

  def generate_and_save_dalle_image(image)
    # DALL-E APIを呼び出して画像を生成
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    response = client.images.generate(parameters: { prompt: image.image_title, size: "256x256" }) # promptにimage_titleを使用
    dall_e_image_url = response.dig("data", 0, "url")
    image.update(dall_e_image_url: dall_e_image_url)

    # 生成された画像をS3に保存
    downloaded_image = URI.open(dall_e_image_url)
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = s3.bucket(ENV['AWS_S3_BUCKET'])
    object = bucket.object("images/#{image.id}.png")
    object.upload_file(downloaded_image.path)
    image.update(s3_image_url: object.public_url)
  end
end