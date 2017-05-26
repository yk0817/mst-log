require 'rails_helper'

describe  do
  it "add 2 an 1 to make 3" do
    expect(2 + 1).to eq 3
  end
  # 
  it "test_hash_for_save_instance" do
    hash = {}
    hash[:instance] = "mstdn.jp"
    hash[:user_id] = 1
    hash[:instance_user_name] = "test_user_name"
    account_params = {"mstdn.jp" => "test_user_name","user_id" => 1}
    expect(CrawlState.hash_for_save_instance("mstdn.jp",account_params)).to eq hash
  end
end


# Rspec メモ
# 
# コマンド
# 
# $ bundle exec rspec spec/controllers/user_controller_spec.rb
# 
# $ bundle exec rspec spec/controllers/
# 
