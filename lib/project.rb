class Project

  attr_accessor :id, :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(param)
    self.title == param.title && self.id == param.id
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end
  
  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects << Project.new({:title => title, :id => id})
    end
    projects
  end

  def self.find(id)
  project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
  title = project.fetch("title")
  id = project.fetch("id").to_i
  Project.new({:title => title, :id => id})
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
  
end