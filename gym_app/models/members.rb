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

end
