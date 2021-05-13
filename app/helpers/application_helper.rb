module ApplicationHelper

  # render 'form'使用時のsubmitボタン表示分け
  def submit_name
    if controller.action_name == 'new'
      '新規登録'
    elsif controller.action_name == 'edit'
      '更新'
    end
  end
end
