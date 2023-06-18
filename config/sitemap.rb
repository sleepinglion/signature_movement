# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.anti-kb.site"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:

  add reports_path, :priority => 0.9, :changefreq => 'daily'

  Report.find_each do |report|
    add report_path(report), :lastmod => report.updated_at
  end

  add compliments_path, :priority => 0.9, :changefreq => 'daily'

  Compliment.find_each do |compliment|
    add compliment_path(compliment), :lastmod => compliment.updated_at
  end

  add notices_path

  Notice.find_each do |notice|
    add notice_path(notice), :lastmod => notice.updated_at
  end
end
