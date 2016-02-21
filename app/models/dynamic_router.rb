class DynamicRouter
  def self.load
    Walkaboutio::Application.routes.draw do
      Page.all.each do |pg|
        get "/#{pg.name}", to: "pages#instapage", defaults: { id: pg.id }
      end
    end
  end

  def self.reload
    Walkaboutio::Application.routes_reloader.reload!
  end
end