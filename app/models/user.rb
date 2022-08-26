class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :color, format: { with: /\A#(\h{3}){1,2}\z/ }

  has_many :questions, dependent: :delete_all
  has_many :asked_questions, class_name: 'Question', foreign_key: :author_id, dependent: :nullify #можно удалить

  def downcase_nickname
    nickname.downcase!
    email.downcase!
  end
end
