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
  end
end

