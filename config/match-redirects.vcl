if (req.http.host ~ "^gems.") {
  error 600 "https://rubygems.org";
}

if (req.http.host ~ "^rspec.") {
  error 600 "https://rspec.info";
}

if (req.http.host ~ "^mocha.") {
  error 600 "https://github.com/freerange/mocha";
}

if (req.url.path ~ "^/projects/mocha/") {
  error 600 "https://github.com/freerange/mocha";
}