class SessionsController < ApplicationController
	def new

	end
	
	def create
		##Formdan girilen email bilgisi ile veritabanımda eşleşen kayıt varmı ?
		user = User.find_by(email: params[:session][:email].downcase)
		## Girilen şifre has_secure_password ile veritabanımdaki ile karşılaştırılıyor
		if user && user.authenticate(params[:session][:password])
			## Bilgiler Doğru ise session[:user_id] diye session başlatılıyor
			## Giriş yapan kullanıcının id bilgisi oturuma kayıt ediliyor
			session[:user_id] = user.id
			flash[:success] = "oturum acıldı"
			redirect_to user_path(user)
		else		
			flash.now[:danger] = "hata"
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "oturum sonlandırıldı"
		redirect_to root_path
	end	

end
