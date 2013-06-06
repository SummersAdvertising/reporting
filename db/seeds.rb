# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.create :username => "書婷", :email => "paula@summers.com.tw", :password => "123", :password_confirmation => '123'
user2 = User.create :username => "Andy", :email => "andy@summers.com.tw", :password => "123", :password_confirmation => '123'
user3 = User.create :username => "威哥", :email => "awhere@summers.com.tw", :password => "123", :password_confirmation => '123'
user4 = User.create :username => "晟祐", :email => "roger@summers.com.tw", :password => "123", :password_confirmation => '123'
user5 = User.create :username => "小丁", :email => "limin@summers.com.tw", :password => "123", :password_confirmation => '123'
user6 = User.create :username => "托托", :email => "toto@summers.com.tw", :password => "123", :password_confirmation => '123'
user7 = User.create :username => "Winnie", :email => "winnie@summers.com.tw", :password => "123", :password_confirmation => '123'
user8 = User.create :username => "Magic", :email => "magic@summers.com.tw", :password => "123", :password_confirmation => '123'
user9 = User.create :username => "琬青", :email => "ching@summers.com.tw", :password => "123", :password_confirmation => '123'
user10 = User.create :username => "思勻", :email => "yun@summers.com.tw", :password => "123", :password_confirmation => '123'
user11 = User.create :username => "玲瑩", :email => "lychen@summers.com.tw", :password => "123", :password_confirmation => '123'
user12 = User.create :username => "Hana", :email => "kobanae@summers.com.tw", :password => "123", :password_confirmation => '123'
user13 = User.create :username => "聿琳", :email => "tc@summers.com.tw", :password => "123", :password_confirmation => '123'
user14 = User.create :username => "Yuzhe", :email => "yuzhe@summers.com.tw", :password => "123", :password_confirmation => '123'
user15 = User.create :username => "ADMIN", :email => "admin@summers.com.tw", :password => "123", :password_confirmation => '123', :role => "admin"