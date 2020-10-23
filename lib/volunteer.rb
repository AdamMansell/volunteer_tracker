# frozen_string_literal: true

class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def ==(volunteer)
    return false if volunteer.nil?

    (name == volunteer.name) && (project_id == volunteer.project_id)
  end

  def save
    if name && project_id
      results = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{name}', #{project_id}) RETURNING id;")
      @id = results.first.fetch('id').to_i
    end
  end

  def update(attributes)
    if attributes[:name]
      @name = attributes[:name]
      DB.exec("UPDATE volunteers SET name = '#{name}' WHERE id = #{id};")
    end
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{id}")
  end

  class << self
    def find(id)
      volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
      if volunteer
        name = volunteer['name']
        project_id = volunteer['project_id'].to_i
        id = volunteer['id'].to_i
        Volunteer.new(name: name, project_id: project_id, id: id)
      end
    end

    def all
      volunteers = []
      results = DB.exec('SELECT * FROM volunteers;')
      results&.each do |volunteer|
        volunteers << Volunteer.new(id: volunteer['id'].to_i, name: volunteer['name'], project_id: volunteer['project_id'].to_i)
      end
      volunteers
    end
  end
end
