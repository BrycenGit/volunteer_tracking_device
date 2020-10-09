class Project

  attr_accessor :id, :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(param)
    self.title == param.title && self.id == param.id
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      title = project.fetch("title")
      id = project.fetch{"id"}
      projects << Project.new({:title => title, :id => id})
    end
    projects
  end

end