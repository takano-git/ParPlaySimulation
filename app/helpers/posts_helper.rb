module PostsHelper

  # current_userの編集,削除ボタンのみ表示する
  def current_user_edit_post(post)
    if current_user.id == post.user_id
      link_to "", edit_golfclub_post_path(@golfclub, post), class: "fas fa-edit"
    end
  end

  # current_userの編集,削除ボタンのみ表示する
  def current_user_destroy_post(golfclub, post)
    if current_user.id == post.user_id
      link_to "", golfclub_post_path(golfclub, post), 
                    class: "fas fa-trash-alt",
                    method: :delete,
                    remote: true,
                    data: { confirm: "タイトル: #{post.title} を削除してよろしいですか？",
                            cancel: 'キャンセル',
                            commit: '削除する'
                          }, title: '削除確認'
    end
  end

  # ユーザーニックネーム表示
  def user_nickname(post)
    nickname = User.find(post.user_id).nickname
    nickname.present? ? nickname : "匿名さん"
  end
end
