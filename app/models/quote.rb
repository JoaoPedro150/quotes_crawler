class Quote 
  include Mongoid::Document
  include Mongoid::Timestamps
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array
  
  has_and_belongs_to_many :associeted_tags, class_name: "Tag", primary_key: :name, foreign_key: :tags
end
