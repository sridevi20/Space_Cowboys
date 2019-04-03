require('pg')

class BountyTrack
  attr_accessor :name, :species, :bounty, :danger_level
  attr_reader :id

  def initialize(hunter)
    @name = hunter['name']
    @species = hunter['species']
    @bounty = hunter['bounty'].to_i
    @danger_level = hunter['danger_level']
    @id = hunter['id'].to_i if hunter['id']
  end
  #write a save method that saves bounty
  def save()
    #first connect to the database
    db = PG.connect( {dbname: 'Bounty', host:'localhost'} )
    # prepare an SQL statement in a big string
    sql = "INSERT INTO Bounty_Tracks
    (
      name,
      species,
      bounty,
      danger_level
    )
    VALUES ($1,$2,$3,$4)
    RETURNING id
    "

    #create a values of array for any prepare statement
    values = [@name, @species, @bounty, @danger_level]

    # use pg to run the prepared statement
    db.prepare("save", sql)

    #run that prepared statement with pg
    @id = db.exec_prepared("save", values)[0]["id"].to_i

    #finally, close the db connection
    db.close()

  end

  def BountyTrack.all()
    #first create db connection
    db = PG.connect( {dbname: 'Bounty', host:'localhost'} )

    # write a big sql string statement
    sql = "SELECT * FROM Bounty_Tracks"

    # prepare the statement
    db.prepare("all", sql)

    #run the prepared statement
    hunter = db.exec_prepared("all")

    #close the db
    db.close()
    # return all the hunter the query found
    # returns a list of bountrytrack objects newly created in the map.
    return hunter.map{ |hunter| BountyTrack.new(hunter) }

  end


  def BountyTrack.delete_all()
    #first create db connection
    db = PG.connect( {dbname: 'Bounty', host:'localhost'} )

    # write a big sql string statement
    sql = "DELETE  FROM Bounty_Tracks"

    #prepare the statement
    db.prepare("delete_all", sql)

    #execute the prepare statement
    hunter = db.exec_prepared("delete_all")

    #close the db connection
    db.close()
  end

  def update()
    # first create db connection
    db = PG.connect( {dbname: 'Bounty', host:'localhost'} )

    # write a sql string statement
    sql = "UPDATE Bounty_Tracks
    SET (
      name,
      species,
      bounty,
      danger_level
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5 "

      # create a value array for the preparesd statement

      values = [@name, @species, @bounty, @danger_level, @id]

      # prepare the statement
      db.prepare("update", sql)

      #run the prepared statement
      db.exec_prepared("update", values)

      #close the db connection
      db.close()

    end
  end
