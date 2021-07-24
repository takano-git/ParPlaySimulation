module ApplicationHelper

  # render 'form'使用時のsubmitボタン表示分け
  def submit_name
    if controller.action_name == 'new'
      '新規登録'
    elsif controller.action_name == 'edit'
      '更新'
    end
  end

  # S3の画像をCloudFront経由で配信する
  def cdn_ready_blob_path(attachment)
    service = Rails.application.config.active_storage.service
    if service == :local
      # 元々のヘルパ
      rails_blob_path(attachment)
    elsif service == :amazon
      # S3上でのファイル名を取得してURLを組み立てる
      key = attachment&.blob&.key
      "https://d2kwpys0kzwrih.cloudfront.net/#{key}"
    end
  end
end
