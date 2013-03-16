## Introduction
_Calendar view_ is a rails plugin which extends application of calendar views. Got to [this page](http://todryk.pl/hard-soft/calendar-view) to see samples.

## Requirements

Plugin was built as Rails 3 Engine plugin.

## Usage

Add to Gemfile of application:

```ruby
gem "calendar_view"
```

than

```shell
bundle install
```

to install gem.

There are two themes current available:
- olive
- bootstrap

In Rails 3 app add import directive to Your SCSS/SASS file:

```scss
@import "calendar_view_bootstrap_theme"

or 

```scss
@import "calendar_view_olive_theme"

In views of Your application add:

```ruby
<%= calendar_window(:back=>10,:forward=>20) %>
<% 1.upto(6) do |i| %>
<%=  calendar_square(:month=>i,:highlight_between => Date.new(2011,9,19)..Date.new(2011,9,25)) %>
<% end %>
<%= calendar_square %>
<%= calendar_square(:month_delta=>-12,:year_delta=>-1) %>
<%= calendar_square(:month_delta=>12) %>
<%= calendar_square(:month=>12,:highlight_date => Date.new(2011,12,2)) %>
<%= calendar_square(:month=>1,:first_wday=>0) %>
<%= calendar_square(
                   :month => 1,                                                    # month
                   :year => 2011,                                                  # year
                   :month_delta => -1,                                             # relative to month
                   :year_delta => -2,                                              # relative to year
                   :first_wday => 0,                                               # start of week 0 - Sunday, 1 - Monday
                   :highlight_date => Date.new(2011,12,2),                         # highlight specific day
                   :highlight_day => 2,                                            # highlight specific day
                   :highlight_month => 12,                                         # highlight specific day
                   :highlight_year => 2011,                                        # highlight specific day
                   :highlight_between => Date.new(2011,12,1)..Date.new(2011,12,10) # highlight range of days
                   ) %>
```

Customize _public/stylesheets_ and copy to Your public directory.


