# == Schema Information
#
# Table name: mixtapes
#
#  id         :integer          not null, primary key
#  artist     :string(255)
#  mx_name    :string(255)
#  mx_cover   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  mx_artist  :string(255)
#

class Mixtapes < ActiveRecord::Base
end
