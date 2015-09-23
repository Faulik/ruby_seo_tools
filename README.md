[![Gem Version](https://badge.fury.io/rb/seo_app.svg)](http://badge.fury.io/rb/seo_app)

# Seo tools

Provides ability to scan selected pages for headers and all the links on page. Generating static html reports and serves them.

### Heroku link

http://rubyseoapp.herokuapp.com/


### Install
  
`bundle install --path vendor/bundle`

### Usage from cli as gem
```
~/> seo_app
Commands:
  seo_app help [COMMAND]  # Describe available commands or one specific command
  seo_app list [options]  #  get all reports in current folder or specific path
  seo_app parse url       # Creates report html in current directory
```
```
~/> seo_app parse google.com
Parsing from url: google.com
Saving in ~/
Done!
```
```
~/> seo_app list
Getting all reports from ~/
Site url -- date of parsing -- key
google.com -- 2015.23.09 02-15-17 -- google.com__2015.23.09_02-15-17.html
That's all
```

### Run
  
`rackup config.ru`

`bundle exec rackup config.ru`

### Test

`bundle exec rspec`

### Example

![Index image](https://raw.githubusercontent.com/Faulik/ruby_seo_tools/master/public/img/index_page.png)

![Report image](https://raw.githubusercontent.com/Faulik/ruby_seo_tools/master/public/img/report_page.png)

Released under the MIT license
