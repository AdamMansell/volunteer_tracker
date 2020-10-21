class Volunteer
  attr_reader :id, :name, :project_id, :hours

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
    @hours = 0
  end

  def ==(volunteer)
    return false if volunteer.nil?
    # its an instance method, so inside this method, self is the instance of Volunteer class

    (name == volunteer.name) && (project_id == volunteer.project_id) && (hours == volunteer.hours)
  end

  def save
    if (self.name != nil) && (self.project_id != nil)
      result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
      @id = result.first.fetch('id').to_i
    end
  end

  # volunteer = Volunteer.find(1)
  # voulnteer.update(name: 'New Name')
  # voulnteer.update(hours: 5)

  # v1 = Volunteer.new(name: 'Adam', project_id: 1)
  # v2 = Volunteer.new(name: 'Adam', project_id: 1)
  # v1 == v2 => false (because the object_id is different)

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:hours)) && (attributes.fetch(:hours) != nil)
      @hours = @hours + (attributes.fetch(:hours).to_i)
      DB.exec("UPDATE volunteers SET hours = #{@hours} WHERE id = #{@id};")
    end
  end

  # volunteer = Volunteer.find(1)
  # volunteer.delete
  def delete 
    DB.exec("DELETE FROM volunteers WHERE id = #{@id}")
  end

    # self
  # here self is the class itself: Volunteer
  # def Volunteer.all
  # def self.all
  # end

  # Volunteer.find(1)
  # return the volunteer record with matching ID

  # def self.find(id)
  # end

  class << self
    def find(id)
      volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
      if volunteer
        name = volunteer.fetch('name')
        project_id = volunteer.fetch('project_id').to_i
        id = volunteer.fetch('id').to_i
        Volunteer.new({name: name, project_id: project_id, id: id})
      else
        nil
      end
    end

    def all
      volunteers = []
      returned_volunteers = DB.exec("SELECT * FROM volunteers;")
      if returned_volunteers != nil
        returned_volunteers.each do |volunteer|
          name = volunteer.fetch('name')
          project_id = volunteer.fetch('project_id').to_i
          id = volunteer.fetch('id').to_i
          volunteers << Volunteer.new({name: name, project_id: project_id, id: id})
        end
      end
      volunteers
    end
  end
end