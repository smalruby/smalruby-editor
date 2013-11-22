# encoding: utf-8

step 'トップページにアクセスする' do
  visit '/'
end

step 'エディタが表示されていること' do
  expect(page).to have_selector('#editor')
end
