require 'net/http'
require "minitest/autorun"

DOMAIN = ENV.fetch('DOMAIN', 'rubyforge.org')

puts "Running tests against #{DOMAIN}"

class TestFastlyConfiguration < Minitest::Test
  def test_everything_else_is_404
    response = request "http://made-up-subdomain.#{DOMAIN}"
    assert_equal '404', response.code
    assert_match 'https://github.com/freerange/rubyforge-redirects', response.body
  end

  def test_apex
    response = request "http://#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "http://www.#{DOMAIN}/", response['Location']
  end

  def test_sequel
    response = request "http://sequel.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://sequel.jeremyevans.net", response['Location']
  end

  def test_rack
    response = request "http://rack.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://rack.github.io/rack/", response['Location']
  end

  def test_rake
    response = request "http://rake.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://ruby.github.io/rake/", response['Location']
  end

  def test_wxruby
    response = request "http://wxruby.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://github.com/mcorino/wxRuby3/wiki", response['Location']
  end

  def test_amazon
    response = request "http://amazon.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://github.com/marcel/aws-s3", response['Location']
  end

  def test_god
    response = request "http://god.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "http://godrb.com", response['Location']
  end

  def test_juggernaut
    response = request "http://juggernaut.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://blog.alexmaccaw.com/killing-a-library/", response['Location']
  end

  def test_webgen
    response = request "http://webgen.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://webgen.gettalong.org", response['Location']
  end

  def test_maruku
    response = request "http://maruku.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://benhollis.net/blog/2013/10/20/maruku-is-obsolete/", response['Location']
  end

  def test_mechanize
    response = request "http://mechanize.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://www.rubydoc.info/gems/mechanize/", response['Location']
  end

  def test_rmagick
    response = request "http://rmagick.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://rmagick.github.io", response['Location']
  end

  def test_kramdown
    response = request "http://kramdown.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://kramdown.gettalong.org", response['Location']
  end

  def test_backgroundrb
    response = request "http://backgroundrb.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://github.com/gnufied/backgroundrb", response['Location']
  end

  def test_wtr
    response = request "http://wtr.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "http://watir.com", response['Location']
  end

  def test_geokit
    response = request "http://geokit.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://github.com/geokit/geokit", response['Location']
  end

  def test_libxml
    response = request "http://libxml.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://xml4r.github.io/libxml-ruby/", response['Location']
  end

  def test_celerity
    response = request "http://celerity.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://github.com/jarib/celerity", response['Location']
  end

  def test_gems
    response = request "http://gems.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "https://rubygems.org", response['Location']
  end

  def test_mocha_subdomain
    response = request "http://mocha.#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal 'https://github.com/freerange/mocha', response['Location']
  end

  def test_mocha_project
    response = request "http://www.#{DOMAIN}/projects/mocha/"
    assert_equal '301', response.code
    assert_equal 'https://github.com/freerange/mocha', response['Location']
  end

  private

  def request(uri)
    Net::HTTP.get_response URI(uri)
  end
end