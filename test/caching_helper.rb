module CachingHelper
  # rubocop:disable Metrics/AbcSize
  def with_caching
    old_type  = Rails.application.config.cache_store
    old_store = Rails.cache
    Rails.application.config.cache_store = [:memory_store, { size: 64.megabytes }]
    Rails.cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 1.minute)

    yield
  ensure
    Rails.cache.clear
    Rails.cache = old_store
    Rails.application.config.cache_store = old_type
  end
  # rubocop:enable Metrics/AbcSize
end
