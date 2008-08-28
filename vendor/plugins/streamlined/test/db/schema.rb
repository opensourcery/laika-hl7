# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define() do

  create_table "articles", :force => true do |t|
    t.column "title",     :string
    t.column "author_id", :integer
  end

  create_table "authors", :force => true do |t|
    t.column "first_name", :string
    t.column "last_name",  :string
  end

  create_table "authorships", :id => false, :force => true do |t|
    t.column "author_id",        :integer, :null => false
    t.column "publication_id",   :integer, :null => false
    t.column "publication_type", :string
  end

  create_table "books", :force => true do |t|
    t.column "title",     :string
    t.column "author_id", :integer
  end

  create_table "people", :force => true do |t|
    t.column "first_name", :string
    t.column "last_name",  :string
  end

  create_table "phone_numbers", :force => true do |t|
    t.column "number", :string
  end

  create_table "poems", :force => true do |t|
    t.column "text",    :string
    t.column "poet_id", :integer
  end

  create_table "poets", :force => true do |t|
    t.column "first_name", :string
    t.column "last_name",  :string
  end

end