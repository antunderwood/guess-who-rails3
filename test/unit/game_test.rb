require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: games
#
#  id         :integer         not null, primary key
#  password   :string(255)
#  state      :string(255)
#  first_turn :integer
#  created_at :datetime
#  updated_at :datetime
#

