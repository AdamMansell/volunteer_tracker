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

  class << self
    def all
      projects = []
      result = DB.exec("SELECT * FROM projects;")
      if result
        result.each do |project|
          projects << Project.new(title: project['title'], id: project['id'])
        end
      end
      projects
    end
  end
end