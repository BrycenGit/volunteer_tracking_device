class Project

  attr_accessor :id, :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(param)
    self.title == param.title && self.id == param.id
  end
end