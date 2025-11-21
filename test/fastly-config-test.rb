require 'net/http'
require "minitest/autorun"

DOMAIN = ENV.fetch('DOMAIN', 'rubyforge.org')

puts "\n*** Running tests against #{DOMAIN} ***\n\n"

EXPECTED_SUBDOMAIN_REDIRECTS = {
  'amazon'       => 'https://github.com/marcel/aws-s3',
  'backgroundrb' => 'https://github.com/gnufied/backgroundrb',
  'celerity'     => 'https://github.com/jarib/celerity',
  'gems'         => 'https://rubygems.org',
  'geokit'       => 'https://github.com/geokit/geokit',
  'god'          => 'http://godrb.com',
  'juggernaut'   => 'https://blog.alexmaccaw.com/killing-a-library/',
  'kramdown'     => 'https://kramdown.gettalong.org',
  'libxml'       => 'https://xml4r.github.io/libxml-ruby/',
  'maruku'       => 'https://benhollis.net/blog/2013/10/20/maruku-is-obsolete/',
  'mechanize'    => 'https://www.rubydoc.info/gems/mechanize/',
  'mocha'        => 'https://github.com/freerange/mocha',
  'rack'         => 'https://rack.github.io/rack/',
  'rake'         => 'https://ruby.github.io/rake/',
  'rmagick'      => 'https://rmagick.github.io',
  'rspec'        => 'https://rspec.info',
  'sequel'       => 'https://sequel.jeremyevans.net',
  'webgen'       => 'https://webgen.gettalong.org',
  'wtr'          => 'http://watir.com',
  'wxruby'       => 'https://github.com/mcorino/wxRuby3/wiki'
}

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

  EXPECTED_SUBDOMAIN_REDIRECTS.each do |subdomain, target_domain|
    define_method "test_#{subdomain}_subdomain" do
      response = request "http://#{subdomain}.#{DOMAIN}"
      assert_equal '301', response.code
      assert_equal target_domain, response['Location']
    end
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
