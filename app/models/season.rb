class Season < Content
  def episodes
    Rails.cache.fetch(["season_episodes_#{id}"], expires_in: 5.minutes) do
      {
          episodes: assets
      }
    end
  end

  def self.cached_results
    Rails.cache.fetch(["seasons"], expires_in: 5.minutes) do
      includes(:assets, :variants).order(created_at: :asc)
    end
  end
end