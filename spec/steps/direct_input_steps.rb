# encoding: utf-8

step 'トップページを表示する' do
  visit '/'
end

step 'エディタが表示されていること' do
  expect(page).to have_selector('#editor')
end
