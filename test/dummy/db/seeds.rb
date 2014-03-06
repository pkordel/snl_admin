User.create!([
  {
    firstname:      'Peter',
    lastname:       'Kordel',
    email_address:  'peter@example.com',
    role:           User::EDITOR
  },
  {
    firstname:      'Django',
    lastname:       'Reinhardt',
    email_address:  'django@example.com',
    role:           User::CONTRIBUTOR
  }
])

root = Taxonomy.create!(title: 'Guitars', position: 0)

Taxonomy.create!([
  {
    title: 'Solidbody Guitars',
    position: 0,
    ancestry: root.id.to_s
  },
  {
    title: 'Acoustic Guitars',
    position: 1,
    ancestry: root.id.to_s
  }
])
