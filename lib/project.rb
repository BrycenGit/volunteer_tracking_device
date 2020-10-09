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

  def volunteers
    volunteers = []
    results = DB.exec("SELECT * FROM projects JOIN volunteers ON (volunteers.project_id = projects.id) WHERE projects.id = #{@id}")
    results.each do |result|
      name = result.fetch("name")
      project_id = result.fetch("project_id").to_i
      id = result.fetch("id").to_i
      volunteers << Volunteer.new({:name => name, :project_id => project_id, :id => id})
    end
    volunteers
  end

  def update(attributes)
    if attributes.has_key?(:title) && attributes.fetch(:title) != nil
      @title = attributes.fetch(:title)
      DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    end
  end

  def add_volunteer(attributes)
    if attributes.has_key?(:name) && attributes.fetch(:name) != nil
    name = attributes.fetch(:name)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE lower(name) = '#{name.downcase}';").first
      if volunteer != nil
        volunteer_id = volunteer.fetch('id').to_i
        DB.exec("UPDATE volunteers SET project_id = #{@id} WHERE id = #{volunteer_id};")
      end
    end
  end
end