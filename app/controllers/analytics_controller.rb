class AnalyticsController < ApplicationController
  #before_action :require_account!


  def index
    @client = Instagram.client(:access_token => set_account.accesstoken)
    @photos = @client.user_recent_media(set_account.uid, {count: @media})
    @followers = @client.user(set_account.uid).counts.followed_by
    @following = @client.user(set_account.uid).counts.follows
    @media = @client.user(set_account.uid).counts.media

    response = @client.user_recent_media
    album = [].concat(response)
    max_id = response.pagination.next_max_id

    while !(max_id.to_s.empty?) do
        response = @client.user_recent_media(:max_id => max_id)
        max_id = response.pagination.next_max_id
        album.concat(response)
    end

    @album = album


    likes = []
    @album.each do |p|
      likes << p.likes[:count]
      @avgLikes = (likes.inject(:+)/@media)
    end

    @follower_names = @client.user_followed_by(set_account.uid)

    names = []
    @first_n = []
    @follower_names.each do |n|
      names << n.full_name
    end
    names.each do |nn|
      @first_n << nn.split(" ").first
    end

    rubular = /[a-zA-Z]/


    @clean = @first_n.reject { |n| n.blank? || !n[rubular]}

    nl = Gendered::NameList.new(@clean)
    @g = nl.collect { |name| name.guess! }
 
    @counts = Hash.new(0)
    @g.each { |nnn| @counts[nnn] += 1 }
    @male = @counts[:male]
    @female = @counts[:female]

    @gTotal = @male + @female

  end

  def show
  end
end