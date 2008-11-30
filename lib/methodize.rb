module Methodize
  def methodize
    self.to_s.downcase.gsub('-','_')
  end
end

class Symbol
  include Methodize
end

class String
  include Methodize
end