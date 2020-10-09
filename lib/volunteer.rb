class Volunteer

  attr_accessor :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(param)
    self.name == param.name && self.id == param.id
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers << Volunteer.new({:name => name, :id => id, :project_id => project_id})
    end
    volunteers
  end

  def save
    if @project_id != nil
      result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
      @id = result.first.fetch('id').to_i
    else
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
    end
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    id = result.fetch("id").to_i
    project_id = result.fetch("project_id").to_i
    name = result.fetch("name")
    Volunteer.new({:name => name, :id => id, :project_id => project_id})
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def update(attributes)
    if attributes.has_key?(:name) && attributes.fetch(:name) != nil
      @name = attributes.fetch(:name)
      DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
    elsif attributes.has_key?(:project_id) && attributes.fetch(:project_id) != nil
      @project_id = attributes.fetch(:project_id)
    end
  end

  def add_project(attributes)
    if attributes.has_key?(:title) && attributes.fetch(:title) != nil
    title = attributes.fetch(:title)
    project = DB.exec("SELECT * FROM projects WHERE lower(title) = '#{title.downcase}';").first
      if project != nil
        @project_id = project.fetch('id').to_i
        DB.exec("UPDATE volunteers SET project_id = #{@project_id} WHERE id = #{@id};")
      end
    end
  end

  def projects
    projects = []
    results = DB.exec("SELECT * FROM volunteers JOIN projects ON (volunteers.project_id = projects.id) WHERE volunteers.id = #{@id}")
    results.each do |result|
      title = result.fetch("title")
      project_id = result.fetch("project_id").to_i
      projects << Project.new({:title => title, :id => project_id})
    end
    projects
  end
end

