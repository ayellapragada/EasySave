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

Place your sql file in the root of the project directory, and name it
`schema.sql`.


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

Run Pry or IRB in the examples folder, and `load 'example.rb'`.

At that point `Users`, `Comments`, `Photos`, and their respective associations can all
be explored.

#### A step by step guide:

1. Clone the repo.
2. Open `EasySave/examples` and Pry / IRB in that same folder.
3. `load 'example.rb'`
4. Try out different things like User.find(1) or Comment.find(2).

## Features

### Example Methods

Methods will return an instance of the object using the information from
the database if appropriate.

#### Object methods: 

* `::all`: Returns an array of all the objects from the corresponding table.
* `::find(id)`: Returns the object corresponding to the row with the ID.
* `::first`: Returns the first row from that table.
* `::table_name`: Returns the instance variable of the table name, or creates
  the table name name and sets the instance variable for future reference.
* `::table_name=(table_name)`: Takes an argument and sets the table name to
  that.
* `#insert`: Inserts the object into it's correponsind table as a new row.
* `#update`: Updates an objects information in the database.
* `#save`: Either updates or inserts an entry in the database, depending on if
  you're already 
* `#finalize!`: Necessary to create the attribute accessors based on database
  columns. Called at the end of the class declaration..

#### Association methods:

* `::belongs_to(name, options)`: Take a model name and an optional options hash
  and creates a method called `#name`. The method returns the instance of the
  model name to whose ID matches the foreign key held by the object calling the
  method.
* `::has_many(name, options)`: Similar to `#belongs_to` but instead returns
  instances of the model name whose foreign key matches the ID help by object
  calling the method.
* `::has_one_through(name, through_name, source_name)`: Requires three
  arguments, the name of the target model class, the through name of the
  intermediary, and the source name of the method in the intermediary. The
  generated method returns an instance of `#name` whose id matches the foreign
  key of the `through_name` object whose id matches the foreign key of the
  `source name` object that is calling the method.



## Future Work

1. `has_many_through` associations
2. Validation check methods
3. `joins` to perform SQL joins



