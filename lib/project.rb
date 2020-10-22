class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def save
    if title
      result = DB.exec("INSERT INTO projects (title) VALUES ('#{title}') RETURNING id;")
      @id = result.first['id'].to_i
    end
  end

  def update(attributes)
    if attributes[:title]
      @title = attributes[:title]
      DB.exec("UPDATE projects SET title = '#{title}' WHERE id = #{id};")
    end
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{id}")
  end

  def volunteers
    volunteers = []
    results = DB.exec("SELECT * from volunteers WHERE project_id = #{id};")
    if results
      results.each do |volunteer|      
        volunteers << Volunteer.new(id: volunteer['id'], name: volunteer['name'], project_id: id)
      end
    end
    volunteers
  end

  def ==(other_project)
    if other_project != nil
      title == other_project.title && id == other_project.id
    else
      false
    end
  end

  class << self
    def find(id)
      project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
      if project
        Project.new(title: project['title'], id: project['id'].to_i)
      end
    end

    def all
      projects = []
      result = DB.exec("SELECT * FROM projects;")
      if result
        result.each do |project|
          projects << Project.new(title: project['title'], id: project['id'].to_i)
        end
      end
      projects
    end
  end
end