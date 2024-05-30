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
class Url < ApplicationRecord
end
