Neat Pages [![Build Status](https://secure.travis-ci.org/alchimikweb/neat-pages.png?branch=master)](http://travis-ci.org/alchimikweb/neat-pages) [![Code Climate](https://codeclimate.com/github/alchimikweb/neat-pages.png)](https://codeclimate.com/github/alchimikweb/neat-pages) [![Coverage Status](https://coveralls.io/repos/alchimikweb/neat-pages/badge.png)](https://coveralls.io/r/alchimikweb/neat-pages)
===============

A simple pagination API to paginate Mongoid Models.

Install
-------

```
gem install neat-pages
```

or add the following line to Gemfile:

```ruby
gem 'neat-pages'
```


Setup
-----

First you need to link the assets.

In your css manifest put : ``` require neat_pages ```

In your javascript manifest put : ``` require neat_pages ```

You only need to require the javascript if you use the AJAX functionnality.

That's it.


Usage
-----


Examples
--------

### Minimal integration

In your controller *(app/controllers/products_controller.rb)*

```ruby
  def index
    paginate

    @products = Product.all.paginate(pagination)
  end
```

In your view *(app/views/products/index.html.erb)*

```erb
  <%= render 'products', products: @products %>
  <%= neat_pages_navigation %>
```


### Summon the power of AJAX

In your controller *(app/controllers/products_controller.rb)*

```ruby
  def index
    paginate

    @products = Product.all.paginate(pagination)
  end
```

In your view *(app/views/products/index.html.erb)*

```erb
  <%= neat_pages_ajax_items 'products', products: @products %>
  <%= neat_pages_navigation %>
```

Create the file *app/views/products/index.neatpage.erb* and place the following code in it.

```erb
  <% self.formats = ["html"] %>
  <%= render 'products', products: @products %>
```
### Events

#### `neat_pages:update`

Triggered on `'body'` whenever a page has changed, from cache or from server.
The event data is an object literal which holds those fields:

`noPage` The current page number

Locales
-------

If you want to translate the text in the pagination helpers, just add the following keys in i18n.

```yml
  fr:
    neat_pages:
      next_page: Page suivante
      previous_page: Page précédente
```


Copyright
---------

Copyright (c) 2013 De Marque inc. See LICENSE for further details.
