require_relative('../db/sql_runner.rb')
require('pry-byebug')


class Member
  attr_reader :first_name, :last_name, :age, :id, :session

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age']
    @session = options['session'].to_i
  end

  def save
    sql = 'INSERT INTO members (first_name, last_name, age, session)
    VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@first_name, @last_name, @age, @session]
    new_member = SqlRunner.run(sql, values)
    @id = new_member.first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM members'
    members = SqlRunner.run(sql)
    return members.map { |member| Member.new(member)  }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM members WHERE id = $1'
    values = [id]
    member_hash = SqlRunner.run(sql,values).first
    return Member.new(member_hash)
  end

  def self.delete_all
    sql = "DELETE FROM members"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE members SET (first_name, last_name, age, session) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@first_name, @last_name, @age, @session, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # binding.pry
end
