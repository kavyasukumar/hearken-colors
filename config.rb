# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def percent_to_rgb(v)
    (v * 255/100).round
  end
  def color_calc
    require 'rgb'
    colors = data.colors.map do |c|
      r = percent_to_rgb c['r']
      g = percent_to_rgb c['g']
      b = percent_to_rgb c['b']
      color = RGB::Color.from_rgb(r, g, b)
      hex = color.to_rgb_hex
      hsl = color.to_hsl
      color2 = RGB::Color.from_fractions(0, 100, 100)
      hex2 = color2.to_rgb_hex
      {
        :name => c['name'],
        :hex => hex,
        :hue => hsl[0].round,
        :hex2 => hex2,
        :r => c['r'],
        :g => c['g'],
        :b => c['b']
      }
    end
    colors = colors.sort_by {|c| c[:hue]}
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  set :http_prefix, '//apps.kavyasukumar.com/hearken-colors'
  activate :minify_css
  activate :minify_javascript
end
