class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def save
    if title
      result = DB.exec("INSERT INTO projects (name) VALUES ('#{title}') RETURNING id;")
      @id = result.first.fetch('id').to_i
    end
  end
end