test_users = [
  ['root', 'root', 'Firsty', 'Lasty', 'root@root.com', 'Rooty', 'Rootin\', Tootin\'', 'white', '#444'],
  ['david', 'david', 'David', 'Elster', 'david@elster.com', 'Dave', 'This app 🙄', '#2b2b2b', '#0b8c8f'],
  ['kobi', 'kobi', 'Kobina', 'Anderson', 'kobi@anderson.com', 'Kobi', 'Ruby, JavaScript', 'yellow', 'blue']
]

test_users.each do |un, pw, fn, ln, em, nn, ho, fc, bc|
  User.create(user_name: un, password: pw, first_name: fn, last_name: ln, email: em, nickname: nn, hobbies: ho, font_color: fc, bg_color: bc)
end

test_posts = [
  ['Hello, World', 'My name is David. This is my first (test) post.', 2],
  ['Hello, World', 'My name is Kobi. This is my first (test) post.', 3],
  ['David\'s 2nd Post', 'This is my second post!', 2],
  ['Kobi\'s 2nd Post', 'This is my second post!', 3]
]

test_posts.each do |title, content, author|
  Post.create(title:title, content:content, user_id:author)
end