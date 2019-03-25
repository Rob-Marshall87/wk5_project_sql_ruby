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

  biding.pry
end
