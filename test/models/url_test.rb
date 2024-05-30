# == Schema Information
#
# Table name: urls
#
#  id         :uuid             not null, primary key
#  original   :string
#  shortened  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
