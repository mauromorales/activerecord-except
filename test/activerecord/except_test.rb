# frozen_string_literal: true

require 'active_record'
require 'test_helper'

class User < ActiveRecord::Base
end

class ExceptTest < Minitest::Test
  def setup
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

    ActiveRecord::Schema.define do
      create_table :users do |t|
        t.string :first_name
        t.string :last_name
        t.string :address
        t.string :file
      end
    end

    User.create!(first_name: 'Max',
                 last_name: 'Musterman',
                 address: 'Berlin',
                 file: 'avatar.jpg')
  end

  def test_except
    user = User.where(address: 'Berlin').except(:file).first

    # implied assertion that no exceptions are raised
    assert_equal user.first_name, 'Max'
    assert_equal user.last_name, 'Musterman'
    assert_equal user.address, 'Berlin'
    assert_raises(NoMethodError) { user.file }
  end
end
