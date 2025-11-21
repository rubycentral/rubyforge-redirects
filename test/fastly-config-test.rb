require 'net/http'
require "minitest/autorun"

DOMAIN = ENV.fetch('DOMAIN', 'rubyforge.org')

puts "\n*** Running tests against #{DOMAIN} ***\n\n"

class TestFastlyConfiguration < Minitest::Test
  def test_everything_else_is_404
    response = request "http://made-up-subdomain.#{DOMAIN}"
    assert_equal '404', response.code
    assert_match 'https://github.com/rubycentral/rubyforge-redirects', response.body
  end

  def test_apex_domain
    response = request "http://#{DOMAIN}"
    assert_equal '301', response.code
    assert_equal "http://www.#{DOMAIN}/", response['Location']
  end

  def test_gems_subdomain
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
