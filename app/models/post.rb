# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

class Post < ApplicationRecord
    has_many :comments
    validates :title, presence: true, length: {minimum: 5}
    belongs_to :user, optional: true
    def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
    end
end
