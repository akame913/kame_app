# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# set User
#User.delete.all
# Admin user
User.create(name: 'Akira Kameyama', email: 'akame913@gmail.com',
            password: 'foobar', password_confirmation: 'foobar', admin: true)
#
# set Product
#Product.delete.all
#
#Product.create(title: '業務システム：設計審査', description: 
#%{設計審査として必要な項目をテンプレート化して、設計審査を補助する。<br />
#項目は<strong>ISO9001の検証と妥当性確認</strong>に準拠
#<ul>
#<li>開発言語</li>
#なでしこ
#<li>データーベース</li>
#Sqlite3
#</ul>}, image_url: 'wfs-0.png')
#
#Product.create(title: '業務システム：不適合是正', description:
#%{品質ISOの不具合是正処理として必要な項目をテンプレート化して不具合是正処理を補助します。<br />
#ISO9000:2000(JISQ9000:2006)では、<strong>是正処置</strong>について以下のように定義しています。#<br />
#検出された不適合またはその他の検出された望ましくない状況の原因を除去するための処置。」
#<ul>
#<li>開発言語</li>
#なでしこ
#<li>データーベース</li>
#Sqlite3
#</ul>}, image_url: 'wfs-1.png')
#     
