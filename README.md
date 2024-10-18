# RubyForge redirects

A project to redirect broken rubyforge.org URLs still in the wild.

## Background

Despite being [taken offline in May 2014][rubyforge-shutdown] there are still many [rubyforge.org URLs in the wild][github-search]. We believe that [cool URIs don't change][uris-dont-change] so have created this project to provide useful redirects for those old rubyforge.org URLs.

This is inspired by [Tom Stuart's rubyforge-redirects project][tomstuart-redirects] from in early 2015, and from [James Mead's blog post][jm-blog-post] in 2017.

## Implementation

The current plan is to use [Fastly's VCL][fastly-vcl] to implement [redirection at the edge][fastly-redirects] for any rubyforge.org URLs we know about. All other requests fall through to a [GitHub Pages hosted 404 page][404] that explains how to contribute to these redirection rules. We configure Fastly to log requests to S3 so that we can additionally monitor requests for URLs that we should add redirects for.

The VCL snippets are in the config/ directory and are currently manually copied to Fastly using the web interface. We might consider automating this if doing it manually becomes too cumbersome.

See the [setup doc](docs/setup.md) for more detailed information about how this is currently configured.

## Tests

We use Ruby to test that the Fastly configuration is working as expected.

```
bundle
ruby test/*.rb
```

## Contributing

The main thing we need help with is mapping old rubyforge.org URLs to their current location. If you can help with this then consider creating a pull request with relevant changes to the tests/fastly config, or creating an issue with the old and new URLs and we'll add the mapping to the config.

[404]: https://github.com/freerange/rubyforge-redirects/blob/gh-pages/404.html
[fastly-redirects]: https://www.fastly.com/documentation/solutions/tutorials/redirects/
[fastly-vcl]: https://www.fastly.com/documentation/reference/vcl/
[github-search]: https://github.com/search?q=rubyforge.org
[jm-blog-post]: https://gofreerange.com/broken-rubyforge-urls
[rubyforge-shutdown]: https://en.wikipedia.org/wiki/RubyForge#Shutting_Down
[tomstuart-redirects]: https://github.com/tomstuart/rubyforge-redirects
[uris-dont-change]: https://www.w3.org/Provider/Style/URI
