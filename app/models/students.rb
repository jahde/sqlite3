class Students  #students
  @@db = SQLite3::Database.new('db/students_store.db')
  @@db.results_as_hash = true

  attr_accessor :id, :name, :super_power
  def self.new_from_row(row)
    s = self.new
    s.id = row["id"]
    s.name = row["name"]
    s.super_power = row["super_power"]
    s
  end

  def self.all
    sql = <<-SQL
    SELECT *
    FROM students
    SQL
    @@db.execute(sql).map do |row|
      new_from_row(row)    # returns the array as an object
    end  # returns a new array of objects
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name="#{name}"
      LIMIT 1
    SQL

    @@db.execute(sql)
  end

end
