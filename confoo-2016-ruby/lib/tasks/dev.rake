namespace :dev do
  desc "Create fake data"
  task seed_fake_data: :environment do
    users_count = ENV.fetch("USERS", 10).to_i - User.count
    posts_count = ENV.fetch("POSTS", 10).to_i - Post.count
    comments_count = ENV.fetch("COMMENTS", 10).to_i - Comment.count

    users_count.times do
      begin
        User.create(
          name: Faker::Name.name,
          email: Faker::Internet.email,
        )
      rescue
      end
    end if users_count > 0

    users = User.all.to_a

    posts_count.times do
      title = Faker::Lorem.sentence
      post = Post.create!(
        user: users.sample,
        slug: title.dasherize,
        title: title,
        body: Faker::Lorem.paragraphs(6),
      )
      5.times do
        Tag.create!(
          post: post,
          name: Faker::Lorem.word,
        )
      end
    end if posts_count > 0

    posts = Post.all.to_a

    comments_count.times do
      Comment.create!(
        user: users.sample,
        post: posts.sample,
        body: Faker::Lorem.sentence,
      )
    end if comments_count > 0
  end
end
