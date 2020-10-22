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
      @id = result.first.fetch('id').to_i
    end
  end

  def update(attributes)
    if attributes[:title]
      @title = attributes[:title]
      DB.exec("UPDATE projects SET title = '#{title}' WHERE id = #{id};")
    end
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