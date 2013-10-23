class Category < ActiveRecord::Base
  has_ancestry

  def self.ancestry_options
    all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? '/' : '') + c.id.to_s
      }.sort {|x,y| x.ancestry <=> y.ancestry
      }.map{ |c| ['-' * (c.depth - 1) + ' ' + c.name,c.id]
      }
  end
end
