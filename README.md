# EasySave

EasySave is a lightweight ORM written in Ruby that abstracts away the
complexities of working with SQL databases. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_save'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_save

## Usage

### Setting up for your own usage: 

Place your sql file in the root of the project directory, and in
`lib/easy_save/db_connection.rb` change `'example.sql'` to your sql file's
name.

```ruby
#lib/easy_save/db_connection.rb
USERS_SQL_FILE = File.join(ROOT_FOLDER, 'example.sql')
USERS_DB_FILE = File.join(ROOT_FOLDER, 'example.db')

```

Once that's done, in each model that is involved in the database, require
'easy_gem', subclass it from SQLObject and `finalize!` it to create the methods.

```ruby
require 'easy_gem'

class User < SQLObject

self.finalize!
end
```

### Setting up demo: 

A demo database has been included as well, in the example folder.

Copy and paste `example.rb` and `example.sql` to the same folder.

Once that's done, run Pry in that same folder, and `load 'example.rb'`.


At that point `Users`, `Comments`, `Photos`, and their respective associations can all
be explored.


## Example Methods

* `#find`
* `#first`
* `#insert`
* `#update`
* `#save`

Also includes associations
* `::has_many`
* `::has_one`
* `::belongs_to`


