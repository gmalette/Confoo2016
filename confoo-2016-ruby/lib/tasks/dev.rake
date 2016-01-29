namespace :dev do
  desc "Create fake data"
  task seed_fake_data: :environment do
    users_count = ENV.fetch("USERS", 10).to_i
    posts_count = ENV.fetch("POSTS", 10).to_i
    comments_count = ENV.fetch("COMMENTS", 10).to_i

    users_count.times do
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
      )
    end

    users = User.all.to_a

    posts_count.times do
      title = Faker::Lorem.sentence
      Post.create!(
        user: users.sample,
        slug: title.dasherize,
        title: title,
        body: Faker::Lorem.paragraphs(6),
      )
    end

    posts = Post.all.to_a

    comments_count.times do
      Comment.create!(
        user: users.sample,
        post: posts.sample,
        body: Faker::Lorem.sentence,
      )
    end
  end
end
