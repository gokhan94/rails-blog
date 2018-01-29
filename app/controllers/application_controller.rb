class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?



  ##Eğer session[:user_id] diye bir session oluşturulmuşsa
  ##ilgili user nesnesini @current_user'a atayalım
  ## Oturumu açan kişinin bilgilerine erişebiliriz
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  ## Kullanıcının oturum açıp açmadığını denetliyor
  def logged_in?
  	!!current_user
  end	

  ## kullanıcının oturum açmadığında gösterilecek uyarı
  def require_user
  	if !logged_in?
  		flash[:danger] = "bu eylemi gerçekleştirmek için giriş yapmış olmalısn"
  		redirect_to root_path
  	end	
  end	

end
