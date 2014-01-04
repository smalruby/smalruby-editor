# -*- coding: utf-8 -*-

# assetsのキャッシュを削除する
#
# ただし、このメソッドを呼び出した後で page.driver.restart を実行しなけ
# ればブラウザ側のキャッシュが有効になったままとなる。
def expire_assets_cache
  env = Rails.application.assets
  if Rails.application.config.cache_classes
    env.instance_variable_set('@assets', {})
    env.instance_variable_set('@digests', {})
    env = env.instance_variable_get('@environment')
  end
  env.send(:expire_index!)
  Dir.glob(Rails.root.join('tmp/cache/assets/test/sprockets/*')) { |f|
    FileUtils.remove_entry_secure(f)
  }
end
