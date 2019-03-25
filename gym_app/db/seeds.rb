require_relative('../models/sessions.rb')
require_relative('../models/members.rb')




session1 = Session.new({'type' => 'Spin Class',
  'instructor' => 'Craig',
  'time' => '17:00'
  })
session1.save

session2 = Session.new({'type' => 'Weights',
  'instructor' => 'Allen',
  'time' => '19:00'
  })
session2.save




member1 = Member.new({'first_name' => 'John',
  'last_name' => 'Smith',
  'age' => 28,
  'session' => session1.id
  })
member1.save

member2 = Member.new({'first_name' => 'Sarah',
  'last_name' => 'Anders',
  'age' => 35,
  'session' => session2.id
  })
member2.save
