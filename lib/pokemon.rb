class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id=nil)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL

      @db = db
      @db.execute(sql, name, type)
      @id = @db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
      sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        LIMIT 1
      SQL
  
      @db = db
      pokemon_details = @db.execute(sql, id).flatten
        pokemon = Pokemon.new
        pokemon.id = (pokemon_details[0])
        pokemon.name = (pokemon_details[1])
        pokemon.type = (pokemon_details[2])
        pokemon
    end
end
