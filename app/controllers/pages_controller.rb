class PagesController < ApplicationController
	def home
		## Kullanıcı giriş yaptıysa onu articles sayfasına yönlendir
		if logged_in?
			redirect_to articles_path 
		end
	end	

	def about

	end	
end	