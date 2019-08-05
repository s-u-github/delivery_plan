source 'https://rubygems.org'

gem 'rails',             '5.1.6'
gem 'bcrypt',            '3.1.12' # パスワードをハッシュ化
gem 'puma',              '3.9.1'
gem 'sass-rails',        '5.0.6'
gem 'uglifier',          '3.2.0'
gem 'coffee-rails',      '4.2.2'
gem 'bootstrap',         '~> 4.1.1'
gem 'jquery-rails',      '4.3.1'
gem 'turbolinks',        '5.0.1'
gem 'jbuilder',          '2.7.0'
gem 'jp_prefecture',     '0.9.0' # 都道府県名変換
gem 'jQuery-Validation-Engine-rails' # jQueryでバリデーション
gem "gmaps4rails"
gem "geocoder"
gem 'gon'
# bulk insert
gem 'activerecord-import'
# カレンダー作成
gem "simple_calendar", "~> 2.0"
# pdf関連
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'



group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]