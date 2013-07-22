class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :cohort_id, :socrates_auth
  has_secure_password
  has_many :topics
  has_many :upvotes
  has_many :upvoted_topics, through: :upvotes,  source: :topic
  has_many :scored_topics, through: :scores, source: :topic
  has_many :scores
  has_many :comments
  belongs_to :cohort


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,
                       uniqueness: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: {with: VALID_EMAIL_REGEX}

  validates :name_slug, uniqueness: true

  before_save {self.email = email.downcase}
  before_create :create_remember_token, :titalize_name


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def authorize_user(current_user)
    self == current_user
  end

  def has_scored?(topic)
    scored_topics.include?(topic)
  end

  def to_param
    name_slug
  end

  #ADD UPDATED COMMENTS ASWELL
  def influence
    self.topics.map(&:upvotes_count).inject(:+)
  end

  def topic_stats
    self.topics.reject(&:anonymous).count
  end

  # GET RID OF ANONYMOUS COMMENTS ASWELL
  def comment_stats
    self.comments.count
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def titalize_name
      self.name_slug = self.name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    end
end

