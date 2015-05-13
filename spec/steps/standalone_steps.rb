# encoding: utf-8

step ":name としてログインする" do |name|
  step %{"signin-button" をクリックする}
  step %{JavaScriptによるアニメーションが終わるまで待つ}
  step %{"signin-modal-username" に "#{name}" を指定する}
  step %{"signin-modal-ok-button" をクリックする}
  step %{JavaScriptによるリクエストが終わるまで待つ}
  step %{JavaScriptによるアニメーションが終わるまで待つ}
end

step "ログインする" do
  step %{"1102" としてログインする}
end

step "ログアウトする" do
  step %{"submenu-button" をクリックする}
  step %{サブメニューの "#signout-button" をクリックする}
  step %{JavaScriptによるリクエストが終わるまで待つ}
  step %{"#main-menu" に "ログイン" を含むこと}
end
