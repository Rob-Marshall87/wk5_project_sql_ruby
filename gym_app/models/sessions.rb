require_relative('../db/sql_runner.rb')
require('pry-byebug')


class Session
  attr_reader :type, :instructor, :time, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @instructor = options['instructor']
    @time = options['time']
  end

  def save
    sql = 'INSERT INTO sessions (type, instructor, time)
    VALUES ($1, $2, $3) RETURNING id'
    values = [@type, @instructor, @time]
    new_session = SqlRunner.run(sql, values)
    @id = new_session.first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM sessions'
    sessions = SqlRunner.run(sql)
    return sessions.map { |session| Session.new(session)  }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM sessions WHERE id = $1'
    values = [id]
    session_hash = SqlRunner.run(sql,values).first
    return Session.new(session_hash)
  end

  def self.delete_all
    sql = "DELETE FROM sessions"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM sessions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE sessions SET (type, instructor, time) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@type, @instructor, @time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM sessions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT * FROM members WHERE session = $1"
    values = [@id]
    members_hash = SqlRunner.run(sql, values)
    return members_hash.map { |member| Member.new(member) }
  end

  # binding.pry
end
