test_users = [
  ['root', 'root', 'ADMIN', 'ADMIN', 'mail@mail.com', 'ADMin', 'HEY\', NO\'', 'white', 'white'],

]

test_users.each do |un, pw, fn, ln, em, nn, ho, fc, bc|
  User.create(user_name: un, password: pw, first_name: fn, last_name: ln, email: em, nickname: nn, hobbies: ho, font_color: fc, bg_color: bc)
end

test_posts = [
  ['Hello, World', 'My name is Sarah. This is my first (test) post.', 2],

]

test_posts.each do |title, content, author|
  Post.create(title:title, content:content, user_id:author)
end
