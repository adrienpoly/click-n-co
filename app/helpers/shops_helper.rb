module ShopsHelper
  def distance(dist)
    return '' unless dist
    if dist > 1
      return "#{dist.round(1)} km"
    else
      return "#{(dist.round(2) * 1000).truncate} m"
    end
  end
end
