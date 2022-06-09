class Post < ActiveRecord::Base
  default_scope { includes(:answers).order('answers.votes desc') }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :description, type: :text, analyzer: :english
    end
  end

  def self.search(query)
    __elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fuzziness: 'AUTO',
          fields: %w[title body]
        }
      }
    })
  end

  belongs_to :user
  has_many :answers, :as => :answerable

  after_commit :flush_cache

  def total_votes
    answers.sum(:votes)
  end

  def flush_cache
    Rails.cache.delete(['user', id])
  end
end
